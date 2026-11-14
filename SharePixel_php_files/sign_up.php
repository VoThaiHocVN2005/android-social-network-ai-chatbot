<?php

require_once 'connection.php';

if (!isset($_POST['username']) || !isset($_POST['email']) || !isset($_POST['password']) ||
	!is_string($_POST['username']) || !is_string($_POST['email']) || !is_string($_POST['password'])) {
	sharepixelJsonError('Username, email, and password are required.');
}

$username = trim($_POST['username']);
$email = trim($_POST['email']);
$password = $_POST['password'];

if ($username === '' || strlen($username) > 50 ||
	!filter_var($email, FILTER_VALIDATE_EMAIL) || strlen($email) > 50 ||
	strlen($password) < 8 || strlen($password) > 72) {
	sharepixelJsonError('Enter a valid username, email, and password of 8 to 72 bytes.');
}

$stmt = $con->prepare('SELECT id FROM users WHERE username = ? OR email = ?');
if (!$stmt) {
	sharepixelJsonError('Unable to process the registration request.', 500);
}

$stmt->bind_param('ss', $username, $email);
if (!$stmt->execute()) {
	$stmt->close();
	sharepixelJsonError('Unable to process the registration request.', 500);
}
$stmt->store_result();
$already_registered = $stmt->num_rows > 0;
$stmt->close();

if ($already_registered) {
	sharepixelJsonError('User already registered', 409);
}

$password_hash = password_hash($password, PASSWORD_DEFAULT);
if ($password_hash === false) {
	sharepixelJsonError('Unable to secure the account password.', 500);
}

$image = $base_url . '/users_images/default_user.png';
$followers = 0;
$following = 0;
$posts = 0;
$stmt = $con->prepare('INSERT INTO users (username, email, password, image, followers, following, posts) VALUES (?, ?, ?, ?, ?, ?, ?)');
if (!$stmt) {
	sharepixelJsonError('Unable to create the account.', 500);
}

$stmt->bind_param('ssssiii', $username, $email, $password_hash, $image, $followers, $following, $posts);
if (!$stmt->execute()) {
	$stmt->close();
	sharepixelJsonError('Unable to create the account.', 500);
}
$user_id = $stmt->insert_id;
$stmt->close();

$api_session = sharepixelIssueApiToken($con, $user_id);

echo json_encode(array(
	'error' => false,
	'message' => 'User registered successfully',
	'user' => array(
		'id' => (int) $user_id,
		'username' => $username,
		'email' => $email,
		'image' => $image,
		'followers' => $followers,
		'following' => $following,
		'posts' => $posts,
		'is_admin' => false,
		'api_token' => $api_session['token'],
		'api_token_expires_at' => $api_session['expires_at']
	)
));

?>
