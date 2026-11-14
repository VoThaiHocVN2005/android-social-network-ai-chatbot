<?php

require_once 'connection.php';

$user_id = isset($_GET['user_id']) ? $_GET['user_id'] : null;
$story_id = isset($_GET['story_id']) ? $_GET['story_id'] : null;
sharepixelRequireUserToken($con, $user_id);
sharepixelChangeStoryRelation($con, 'likes', $user_id, $story_id, true);

echo json_encode(array('error' => false, 'message' => 'Like saved.'));

?>