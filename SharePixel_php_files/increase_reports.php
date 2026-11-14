<?php

require_once 'connection.php';

sharepixelChangeStoryRelation($con, 'reports', $authenticated_user['id'], isset($_GET['story_id']) ? $_GET['story_id'] : null, true);

echo json_encode(array('error' => false, 'message' => 'Report saved.'));

?>