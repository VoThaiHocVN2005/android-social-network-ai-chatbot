<?php

require_once 'connection.php';

$required = array('image_name', 'image_encoded', 'user_id');
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

$image_data = sharepixelReadJpeg($_POST['image_encoded']);
$image_name = $_POST['image_name'];
$image_url = $base_url . '/users_images/' . $image_name . '.jpg';
$image_path = __DIR__ . DIRECTORY_SEPARATOR . 'users_images' . DIRECTORY_SEPARATOR . $image_name . '.jpg';
$image_directory = dirname($image_path);
if (!is_dir($image_directory) && !mkdir($image_directory, 0755, true) && !is_dir($image_directory)) {
	sharepixelJsonError('Unable to prepare image storage.', 500);
}

if (file_put_contents($image_path, $image_data, LOCK_EX) === false) {
	sharepixelJsonError('Unable to save the uploaded image.', 500);
}

$stmt = $con->prepare('UPDATE users SET image = ? WHERE id = ?');
if (!$stmt) {
	unlink($image_path);
	sharepixelJsonError('Unable to update the profile image.', 500);
}
$stmt->bind_param('si', $image_url, $user_id);
if (!$stmt->execute()) {
	$stmt->close();
	unlink($image_path);
	sharepixelJsonError('Unable to update the profile image.', 500);
}
$stmt->close();

echo json_encode(array('error' => false, 'message' => 'Profile image uploaded successfully.', 'image' => $image_url));

?>
