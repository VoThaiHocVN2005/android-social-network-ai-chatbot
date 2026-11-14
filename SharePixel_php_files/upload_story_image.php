<?php

require_once 'connection.php';

$required = array('image_name', 'image_encoded', 'user_id', 'title', 'time');
foreach ($required as $parameter) {
	if (!isset($_POST[$parameter]) || !is_string($_POST[$parameter])) {
		sharepixelJsonError('Required parameters are not available.');
	}
}

$user_id = filter_var($_POST['user_id'], FILTER_VALIDATE_INT, array('options' => array('min_range' => 1)));
if ($user_id === false) {
	sharepixelJsonError('Invalid user ID.');
}
sharepixelRequireUserToken($con, $user_id);
sharepixelValidateImageName($_POST['image_name']);

$title = trim($_POST['title']);
$time = trim($_POST['time']);
if (strlen($title) > 500 || $time === '' || strlen($time) > 50) {
	sharepixelJsonError('Invalid post details.');
}

$user_stmt = $con->prepare('SELECT username, image FROM users WHERE id = ?');
if (!$user_stmt) {
	sharepixelJsonError('Unable to load the user profile.', 500);
}
$user_stmt->bind_param('i', $user_id);
if (!$user_stmt->execute()) {
	$user_stmt->close();
	sharepixelJsonError('Unable to load the user profile.', 500);
}
$user_stmt->bind_result($username, $profile_image);
if (!$user_stmt->fetch()) {
	$user_stmt->close();
	sharepixelJsonError('User was not found.', 404);
}
$user_stmt->close();

$image_data = sharepixelReadJpeg($_POST['image_encoded']);
$image_name = $_POST['image_name'];
$image_url = $base_url . '/story_images/' . $image_name . '.jpg';
$image_path = __DIR__ . DIRECTORY_SEPARATOR . 'story_images' . DIRECTORY_SEPARATOR . $image_name . '.jpg';
$image_directory = dirname($image_path);
if (!is_dir($image_directory) && !mkdir($image_directory, 0755, true) && !is_dir($image_directory)) {
	sharepixelJsonError('Unable to prepare image storage.', 500);
}

if (file_put_contents($image_path, $image_data, LOCK_EX) === false) {
	sharepixelJsonError('Unable to save the uploaded image.', 500);
}

if (!$con->begin_transaction()) {
	unlink($image_path);
	sharepixelJsonError('Unable to save the post.', 500);
}

$image_stmt = $con->prepare('INSERT INTO images (image_name, image_url, user_id) VALUES (?, ?, ?)');
$story_stmt = $con->prepare('INSERT INTO stories (user_id, image_url, title, time, username, profile_image, image_name) VALUES (?, ?, ?, ?, ?, ?, ?)');
if (!$image_stmt || !$story_stmt) {
	$con->rollback();
	unlink($image_path);
	sharepixelJsonError('Unable to save the post.', 500);
}

$image_stmt->bind_param('ssi', $title, $image_url, $user_id);
$story_stmt->bind_param('issssss', $user_id, $image_url, $title, $time, $username, $profile_image, $image_name);
$image_saved = $image_stmt->execute();
$story_saved = $image_saved && $story_stmt->execute();
$image_stmt->close();
$story_stmt->close();

if (!$story_saved || !$con->commit()) {
	$con->rollback();
	unlink($image_path);
	sharepixelJsonError('Unable to save the post.', 500);
}

echo json_encode(array('error' => false, 'message' => 'Story published successfully.'));

?>
