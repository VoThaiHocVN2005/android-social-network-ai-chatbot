<?php

require_once 'connection.php';

if (!isset($_POST['username']) || !isset($_POST['password']) ||
	!is_string($_POST['username']) || !is_string($_POST['password'])) {
	sharepixelJsonError('Username and password are required.');
}

$username = trim($_POST['username']);
$password = $_POST['password'];
if ($username === '' || strlen($username) > 50 || $password === '') {
	sharepixelJsonError('Invalid username or password.', 401);
}

$stmt = $con->prepare('SELECT id, username, password, email, image, followers, following, posts, is_admin FROM users WHERE username = ?');
if (!$stmt) {
	sharepixelJsonError('Unable to process the login request.', 500);
}

$stmt->bind_param('s', $username);
if (!$stmt->execute()) {
	$stmt->close();
	sharepixelJsonError('Unable to process the login request.', 500);
}

$stmt->bind_result($id, $stored_username, $stored_password, $email, $image, $followers, $following, $posts, $is_admin);
$found = $stmt->fetch();
$stmt->close();

$password_valid = false;
$is_legacy_hash = isset($stored_password) && is_string($stored_password) &&
	preg_match('/\A[a-f0-9]{32}\z/i', $stored_password);
if ($found && $is_legacy_hash) {
	$password_valid = hash_equals(strtolower($stored_password), md5($password));
} elseif ($found && is_string($stored_password)) {
	$password_valid = password_verify($password, $stored_password);
}

if (!$password_valid) {
	sharepixelJsonError('Invalid username or password.', 401);
}

if ($is_legacy_hash) {
	$new_password_hash = password_hash($password, PASSWORD_DEFAULT);
	if ($new_password_hash === false) {
		sharepixelJsonError('Unable to secure the account password.', 500);
	}

	$upgrade_stmt = $con->prepare('UPDATE users SET password = ? WHERE id = ?');
	if (!$upgrade_stmt) {
		sharepixelJsonError('Unable to secure the account password.', 500);
	}
	$upgrade_stmt->bind_param('si', $new_password_hash, $id);
	if (!$upgrade_stmt->execute()) {
		$upgrade_stmt->close();
		sharepixelJsonError('Unable to secure the account password.', 500);
	}
	$upgrade_stmt->close();
}

$api_session = sharepixelIssueApiToken($con, $id);

echo json_encode(array(
	'error' => false,
	'message' => 'Login successfully',
	'user' => array(
		'id' => (int) $id,
		'username' => $stored_username,
		'email' => $email,
		'image' => $image,
		'followers' => (int) $followers,
		'following' => (int) $following,
		'posts' => (int) $posts,
		'is_admin' => (int) $is_admin === 1,
		'api_token' => $api_session['token'],
		'api_token_expires_at' => $api_session['expires_at']
	)
));

?>
