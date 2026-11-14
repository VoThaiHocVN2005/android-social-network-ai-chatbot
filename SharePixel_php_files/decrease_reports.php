<?php

require_once 'connection.php';

sharepixelChangeStoryRelation($con, 'reports', $authenticated_user['id'], isset($_GET['story_id']) ? $_GET['story_id'] : null, false);

echo json_encode(array('error' => false, 'message' => 'Report removed.'));

?>