<?php

require_once 'connection.php';

if (!isset($_SERVER['REQUEST_METHOD']) || $_SERVER['REQUEST_METHOD'] !== 'POST') {
	sharepixelJsonError('POST is required.', 405);
}

if (!isset($_POST['message']) || !is_string($_POST['message'])) {
	sharepixelJsonError('A message is required.');
}

$message = trim($_POST['message']);
if ($message === '' || strlen($message) > 8000 || preg_match('//u', $message) !== 1 ||
	preg_match_all('/./us', $message) > 2000) {
	sharepixelJsonError('Message must be valid text up to 2,000 characters.');
}

if (!isset($config['gemini_api_key']) || !is_string($config['gemini_api_key']) || trim($config['gemini_api_key']) === '') {
	sharepixelJsonError('Chatbot is not configured. Add the Gemini API key to the local server configuration.', 503);
}

$model = isset($config['gemini_model']) && is_string($config['gemini_model'])
	? $config['gemini_model']
	: 'gemini-3.5-flash-lite';
if (!preg_match('/\Agemini-[A-Za-z0-9._-]+\z/', $model)) {
	sharepixelJsonError('The Gemini model configuration is invalid.', 500);
}

if (!function_exists('curl_init')) {
	sharepixelJsonError('The server does not have the cURL extension enabled.', 503);
}

$user_id = $authenticated_user['id'];
$rate_stmt = $con->prepare(
	'SELECT COUNT(*) FROM chat_messages WHERE user_id = ? AND role = \'user\' AND created_at >= CURRENT_TIMESTAMP - INTERVAL 5 MINUTE'
);
if (!$rate_stmt) {
	sharepixelJsonError('Unable to process the chat request.', 500);
}
$rate_stmt->bind_param('i', $user_id);
if (!$rate_stmt->execute()) {
	$rate_stmt->close();
	sharepixelJsonError('Unable to process the chat request.', 500);
}
$rate_stmt->bind_result($recent_message_count);
$rate_stmt->fetch();
$rate_stmt->close();
if ((int) $recent_message_count >= 10) {
	sharepixelJsonError('Please wait a few minutes before sending more messages.', 429);
}

$history_stmt = $con->prepare(
	'SELECT role, message_text FROM chat_messages WHERE user_id = ? ORDER BY id DESC LIMIT 12'
);
if (!$history_stmt) {
	sharepixelJsonError('Unable to load chat context.', 500);
}
$history_stmt->bind_param('i', $user_id);
if (!$history_stmt->execute()) {
	$history_stmt->close();
	sharepixelJsonError('Unable to load chat context.', 500);
}
$history_stmt->bind_result($history_role, $history_text);
$history = array();
while ($history_stmt->fetch()) {
	$history[] = array(
		'role' => $history_role,
		'parts' => array(array('text' => $history_text))
	);
}
$history_stmt->close();
$history = array_reverse($history);
$history[] = array(
	'role' => 'user',
	'parts' => array(array('text' => $message))
);

$request_body = json_encode(array(
	'systemInstruction' => array(
		'parts' => array(array(
			'text' => 'You are the Android Social Network AI Chatbot assistant. Help users with social networking features, photo editing, and sharing. Reply in the user\'s language. Do not claim to access private accounts, messages, or the database.'
		))
	),
	'contents' => $history,
	'generationConfig' => array(
		'maxOutputTokens' => 512
	)
), JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
if ($request_body === false) {
	sharepixelJsonError('Unable to prepare the chat request.', 500);
}

$url = 'https://generativelanguage.googleapis.com/v1beta/models/' . rawurlencode($model) . ':generateContent';
$curl = curl_init($url);
curl_setopt_array($curl, array(
	CURLOPT_POST => true,
	CURLOPT_RETURNTRANSFER => true,
	CURLOPT_HTTPHEADER => array(
		'Content-Type: application/json',
		'x-goog-api-key: ' . trim($config['gemini_api_key'])
	),
	CURLOPT_POSTFIELDS => $request_body,
	CURLOPT_CONNECTTIMEOUT => 10,
	CURLOPT_TIMEOUT => 40,
	CURLOPT_FOLLOWLOCATION => false,
	CURLOPT_SSL_VERIFYPEER => true,
	CURLOPT_SSL_VERIFYHOST => 2
));
$api_response = curl_exec($curl);
$curl_failed = $api_response === false;
$http_status = (int) curl_getinfo($curl, CURLINFO_HTTP_CODE);
curl_close($curl);

if ($curl_failed || $http_status < 200 || $http_status >= 300) {
	error_log('Gemini chat request failed with HTTP status ' . $http_status . '.');
	sharepixelJsonError('The chatbot service is unavailable. Check the server configuration and try again.', 502);
}

$decoded_response = json_decode($api_response, true);
$parts = isset($decoded_response['candidates'][0]['content']['parts'])
	? $decoded_response['candidates'][0]['content']['parts']
	: array();
$reply = '';
foreach ($parts as $part) {
	if (isset($part['text']) && is_string($part['text'])) {
		$reply .= $part['text'];
	}
}
$reply = trim($reply);
if ($reply === '') {
	sharepixelJsonError('Gemini could not provide a response. Rephrase your message and try again.', 502);
}

if (!$con->begin_transaction()) {
	sharepixelJsonError('Unable to save the chat response.', 500);
}
$insert_stmt = $con->prepare('INSERT INTO chat_messages (user_id, role, message_text) VALUES (?, ?, ?)');
if (!$insert_stmt) {
	$con->rollback();
	sharepixelJsonError('Unable to save the chat response.', 500);
}

$role = 'user';
$text = $message;
$insert_stmt->bind_param('iss', $user_id, $role, $text);
$inserted = $insert_stmt->execute();
if ($inserted) {
	$role = 'model';
	$text = $reply;
	$inserted = $insert_stmt->execute();
}
$insert_stmt->close();
if (!$inserted || !$con->commit()) {
	$con->rollback();
	sharepixelJsonError('Unable to save the chat response.', 500);
}

echo json_encode(array(
	'error' => false,
	'reply' => $reply
), JSON_UNESCAPED_UNICODE);

?>
