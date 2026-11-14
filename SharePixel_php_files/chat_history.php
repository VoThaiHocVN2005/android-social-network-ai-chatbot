<?php

require_once 'connection.php';

$user_id = $authenticated_user['id'];
$stmt = $con->prepare(
	'SELECT role, message_text, created_at FROM chat_messages WHERE user_id = ? ORDER BY id DESC LIMIT 50'
);
if (!$stmt) {
	sharepixelJsonError('Unable to load chat history.', 500);
}

$stmt->bind_param('i', $user_id);
if (!$stmt->execute()) {
	$stmt->close();
	sharepixelJsonError('Unable to load chat history.', 500);
}

$stmt->bind_result($role, $message_text, $created_at);
$messages = array();
while ($stmt->fetch()) {
	$messages[] = array(
		'role' => $role,
		'message' => $message_text,
		'created_at' => $created_at
	);
}
$stmt->close();

echo json_encode(array(
	'error' => false,
	'messages' => array_reverse($messages)
), JSON_UNESCAPED_UNICODE);

?>
