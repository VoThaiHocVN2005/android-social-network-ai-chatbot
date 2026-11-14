<?php

require_once 'connection.php';

$user_id = $authenticated_user['id'];
$stmt = $con->prepare('UPDATE users SET api_token_hash = NULL, api_token_expires_at = NULL WHERE id = ?');
if (!$stmt) {
	sharepixelJsonError('Unable to end the API session.', 500);
}

$stmt->bind_param('i', $user_id);
if (!$stmt->execute()) {
	$stmt->close();
	sharepixelJsonError('Unable to end the API session.', 500);
}
$stmt->close();

echo json_encode(array('error' => false, 'message' => 'Logged out successfully.'));

?>
