<?php

require_once 'connection.php';

if (!isset($_GET['limit'], $_GET['offset'])) {
	sharepixelJsonError('Required parameters are not available.');
}

$raw_ids = isset($_GET['following_ids']) ? $_GET['following_ids'] : array();
if (!is_array($raw_ids)) {
	$raw_ids = array($raw_ids);
}
if (count($raw_ids) > 100) {
	sharepixelJsonError('Too many following IDs were provided.');
}

$user_ids = array();
foreach ($raw_ids as $raw_id) {
	$user_id = filter_var($raw_id, FILTER_VALIDATE_INT, array('options' => array('min_range' => 1)));
	if ($user_id === false) {
		sharepixelJsonError('Invalid following ID.');
	}
	$user_ids[] = $user_id;
}

$limit = filter_var($_GET['limit'], FILTER_VALIDATE_INT, array('options' => array('min_range' => 1, 'max_range' => 100)));
$offset = filter_var($_GET['offset'], FILTER_VALIDATE_INT, array('options' => array('min_range' => 0)));
if ($limit === false || $offset === false) {
	sharepixelJsonError('Invalid pagination values.');
}

$stories = array();
if (count($user_ids) > 0) {
	$placeholders = implode(',', array_fill(0, count($user_ids), '?'));
	$stmt = $con->prepare("SELECT * FROM stories WHERE user_id IN ($placeholders) LIMIT ? OFFSET ?");
	if (!$stmt) {
		sharepixelJsonError('Unable to load the news feed.', 500);
	}

	$values = array_merge($user_ids, array($limit, $offset));
	$types = str_repeat('i', count($values));
	$bind_values = array($types);
	foreach ($values as $index => $value) {
		$bind_values[] = &$values[$index];
	}
	if (!call_user_func_array(array($stmt, 'bind_param'), $bind_values) || !$stmt->execute()) {
		$stmt->close();
		sharepixelJsonError('Unable to load the news feed.', 500);
	}

	$result = $stmt->get_result();
	while ($row = $result->fetch_assoc()) {
		$stories[] = $row;
	}
	$stmt->close();
}

echo json_encode(array('error' => false, 'stories' => $stories));

?>
