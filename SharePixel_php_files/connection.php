<?php

header('Content-Type: application/json; charset=utf-8');

$config_path = __DIR__ . DIRECTORY_SEPARATOR . 'db_config.php';
if (!is_file($config_path)) {
	http_response_code(500);
	echo json_encode(array('error' => true, 'message' => 'Server database configuration is missing.'));
	exit;
}

$config = require $config_path;
$required_config = array('db_host', 'db_name', 'db_user', 'db_password', 'base_url');
foreach ($required_config as $key) {
	if (!isset($config[$key]) || !is_string($config[$key]) || $config[$key] === '') {
		http_response_code(500);
		echo json_encode(array('error' => true, 'message' => 'Server database configuration is incomplete.'));
		exit;
	}
}

mysqli_report(MYSQLI_REPORT_OFF);
$con = mysqli_connect(
	$config['db_host'],
	$config['db_user'],
	$config['db_password'],
	$config['db_name']
);

if (!$con) {
	http_response_code(500);
	echo json_encode(array('error' => true, 'message' => 'Unable to connect to the database.'));
	exit;
}

if (!mysqli_set_charset($con, 'utf8mb4')) {
	http_response_code(500);
	echo json_encode(array('error' => true, 'message' => 'Unable to configure the database connection.'));
	exit;
}

$base_url = rtrim($config['base_url'], '/');

function sharepixelJsonError($message, $status = 400) {
	http_response_code($status);
	echo json_encode(array('error' => true, 'message' => $message));
	exit;
}

function sharepixelIssueApiToken($con, $user_id) {
	$token = bin2hex(random_bytes(32));
	$token_hash = hash('sha256', $token);
	$expires_at = time() + 30 * 24 * 60 * 60;
	$expires_at_utc = gmdate('Y-m-d H:i:s', $expires_at);
	$stmt = $con->prepare('UPDATE users SET api_token_hash = ?, api_token_expires_at = ? WHERE id = ?');
	if (!$stmt) {
		sharepixelJsonError('Unable to create an API session.', 500);
	}

	$stmt->bind_param('ssi', $token_hash, $expires_at_utc, $user_id);
	if (!$stmt->execute()) {
		$stmt->close();
		sharepixelJsonError('Unable to create an API session.', 500);
	}
	$stmt->close();

	return array('token' => $token, 'expires_at' => $expires_at);
}

function sharepixelAuthenticateRequest($con) {
	$token = isset($_SERVER['HTTP_X_API_TOKEN']) ? $_SERVER['HTTP_X_API_TOKEN'] : '';
	if (!is_string($token) || !preg_match('/\A[a-f0-9]{64}\z/i', $token)) {
		sharepixelJsonError('Authentication is required.', 401);
	}

	$token_hash = hash('sha256', $token);
	$stmt = $con->prepare('SELECT id, is_admin FROM users WHERE api_token_hash = ? AND api_token_expires_at > UTC_TIMESTAMP()');
	if (!$stmt) {
		sharepixelJsonError('Unable to verify the API session.', 500);
	}

	$stmt->bind_param('s', $token_hash);
	if (!$stmt->execute()) {
		$stmt->close();
		sharepixelJsonError('Unable to verify the API session.', 500);
	}

	$stmt->bind_result($user_id, $is_admin);
	$found = $stmt->fetch();
	$stmt->close();

	if (!$found) {
		sharepixelJsonError('Authentication is required.', 401);
	}

	return array('id' => (int) $user_id, 'is_admin' => (int) $is_admin === 1);
}

function sharepixelChangeStoryRelation($con, $relation, $user_id, $story_id, $add) {
	$relations = array(
		'likes' => 'num_of_likes',
		'reports' => 'num_of_reports'
	);
	if (!isset($relations[$relation])) {
		sharepixelJsonError('Invalid story relation.', 400);
	}

	$user_id = filter_var($user_id, FILTER_VALIDATE_INT, array('options' => array('min_range' => 1)));
	$story_id = filter_var($story_id, FILTER_VALIDATE_INT, array('options' => array('min_range' => 1)));
	if ($user_id === false || $story_id === false) {
		sharepixelJsonError('Invalid user or story ID.', 400);
	}

	if (!$con->begin_transaction()) {
		sharepixelJsonError('Unable to update the story relation.', 500);
	}

	$story_stmt = $con->prepare('SELECT id FROM stories WHERE id = ? FOR UPDATE');
	if (!$story_stmt) {
		$con->rollback();
		sharepixelJsonError('Unable to update the story relation.', 500);
	}
	$story_stmt->bind_param('i', $story_id);
	if (!$story_stmt->execute()) {
		$story_stmt->close();
		$con->rollback();
		sharepixelJsonError('Unable to update the story relation.', 500);
	}
	$story_stmt->store_result();
	$story_exists = $story_stmt->num_rows === 1;
	$story_stmt->close();
	if (!$story_exists) {
		$con->rollback();
		sharepixelJsonError('Story not found.', 404);
	}

	if ($add) {
		$relation_stmt = $con->prepare(
			'INSERT INTO `' . $relation . '` (user_id, story_id) VALUES (?, ?) ON DUPLICATE KEY UPDATE id = id'
		);
	} else {
		$relation_stmt = $con->prepare('DELETE FROM `' . $relation . '` WHERE user_id = ? AND story_id = ?');
	}
	if (!$relation_stmt) {
		$con->rollback();
		sharepixelJsonError('Unable to update the story relation.', 500);
	}
	$relation_stmt->bind_param('ii', $user_id, $story_id);
	if (!$relation_stmt->execute()) {
		$relation_stmt->close();
		$con->rollback();
		sharepixelJsonError('Unable to update the story relation.', 500);
	}
	$relation_stmt->close();

	$counter_column = $relations[$relation];
	$count_stmt = $con->prepare(
		'UPDATE stories SET ' . $counter_column . ' = (SELECT COUNT(*) FROM `' . $relation . '` WHERE story_id = ?) WHERE id = ?'
	);
	if (!$count_stmt) {
		$con->rollback();
		sharepixelJsonError('Unable to update the story count.', 500);
	}
	$count_stmt->bind_param('ii', $story_id, $story_id);
	if (!$count_stmt->execute()) {
		$count_stmt->close();
		$con->rollback();
		sharepixelJsonError('Unable to update the story count.', 500);
	}
	$count_stmt->close();

	if (!$con->commit()) {
		$con->rollback();
		sharepixelJsonError('Unable to update the story relation.', 500);
	}
}

function sharepixelRequireUserToken($con, $user_id) {
	global $authenticated_user;

	$user_id = filter_var($user_id, FILTER_VALIDATE_INT, array('options' => array('min_range' => 1)));
	if ($user_id === false || $authenticated_user === null || $user_id !== $authenticated_user['id']) {
		sharepixelJsonError('You are not allowed to modify this user.', 403);
	}
}

function sharepixelRequireAdmin() {
	global $authenticated_user;

	if ($authenticated_user === null || !$authenticated_user['is_admin']) {
		sharepixelJsonError('Administrator access is required.', 403);
	}
}

function sharepixelReadJpeg($encoded_image) {
	if (!is_string($encoded_image) || strlen($encoded_image) > 14000000) {
		sharepixelJsonError('The image is missing or too large.');
	}

	$image_data = base64_decode($encoded_image, true);
	if ($image_data === false || strlen($image_data) === 0 || strlen($image_data) > 10485760) {
		sharepixelJsonError('The image data is invalid or too large.');
	}

	$image_info = @getimagesizefromstring($image_data);
	if ($image_info === false || $image_info['mime'] !== 'image/jpeg') {
		sharepixelJsonError('Only valid JPEG images are accepted.');
	}

	return $image_data;
}

function sharepixelValidateImageName($image_name) {
	if (!is_string($image_name) || !preg_match('/\A[a-f0-9-]{36}\z/i', $image_name)) {
		sharepixelJsonError('Invalid image name.');
	}
}

$authenticated_user = null;
$endpoint = isset($_SERVER['SCRIPT_NAME']) ? basename($_SERVER['SCRIPT_NAME']) : '';
$public_endpoints = array('login.php', 'sign_up.php');
if (!in_array($endpoint, $public_endpoints, true)) {
	$authenticated_user = sharepixelAuthenticateRequest($con);

	$owner_endpoints = array(
		'add_user_to_likes_db.php',
		'add_user_to_reports_db.php',
		'check_following_state.php',
		'did_user_like_story.php',
		'did_user_report_story.php',
		'follow_this_person.php',
		'get_all_story_ids.php',
		'get_following_ids.php',
		'remove_user_from_likes_db.php',
		'remove_user_from_reports_db.php',
		'send_comment.php',
		'unfollow_this_person.php',
		'update_profile_image.php',
		'update_user_data.php',
		'upload_story_image.php'
	);
	if (in_array($endpoint, $owner_endpoints, true)) {
		$requested_user_id = isset($_POST['user_id']) ? $_POST['user_id'] : (isset($_GET['user_id']) ? $_GET['user_id'] : null);
		sharepixelRequireUserToken($con, $requested_user_id);
	}

	if (in_array($endpoint, array('reported_news_feed.php', 'remove_story.php'), true)) {
		sharepixelRequireAdmin();
	}
}

?>
