package com.beproject.sharepixel;

public class URLS {
    ////static in order to call this without creating obj of class URLS
    private static final String BASE_URL = "http://10.0.2.2/SharePixel/";

    public static final String login_api = BASE_URL + "login.php";
    public static final String sign_up_api = BASE_URL + "sign_up.php";
    public static final String logout_api = BASE_URL + "logout.php";
    public static final String chat_history = BASE_URL + "chat_history.php";
    public static final String chat_send = BASE_URL + "chat.php";
    public static final String upload_story_image = BASE_URL + "upload_story_image.php";
    public static final String get_following_ids = BASE_URL + "get_following_ids.php?user_id=";
    public static final String lasted_news_feed = BASE_URL + "latest_news_feed.php";
    public static final String all_stories_we_liked = BASE_URL + "all_stories_we_liked.php?story_ids[]=";
    public static final String get_all_comments = BASE_URL + "get_all_comments.php?story_id=";
    public static final String send_comment = BASE_URL + "send_comment.php";
    public static final String check_following_state = BASE_URL + "check_following_state.php?other_user_id=";
    public static final String unfollow_this_person = BASE_URL + "unfollow_this_person.php?other_user_id=";
    public static final String follow_this_person = BASE_URL + "follow_this_person.php?other_user_id=";
    public static final String get_user_data = BASE_URL + "get_user_data.php?user_id=";
    public static final String get_similar_users = BASE_URL + "get_similar_users.php?text=";
    public static final String get_all_images = BASE_URL + "get_all_images.php?id=";
    public static final String update_profile_image = BASE_URL + "update_profile_image.php";
    public static final String update_user_data = BASE_URL + "update_user_data.php";
    public static final String increase_likes = BASE_URL + "increase_likes.php?story_id=";
    public static final String decrease_likes = BASE_URL + "decrease_likes.php?story_id=";
    public static final String add_user_to_likes_db = BASE_URL + "add_user_to_likes_db.php?story_id=";
    public static final String remove_user_from_likes_db = BASE_URL + "remove_user_from_likes_db.php?story_id=";
    public static final String did_user_like_story = BASE_URL + "did_user_like_story.php?story_id=";
    public static final String get_all_story_ids = BASE_URL + "get_all_story_ids.php?user_id=";
    // REPORT
    public static final String did_user_report_story = BASE_URL + "did_user_report_story.php?story_id=";
    public static final String increase_reports = BASE_URL + "increase_reports.php?story_id=";
    public static final String decrease_reports = BASE_URL + "decrease_reports.php?story_id=";
    public static final String add_user_to_reports_db = BASE_URL + "add_user_to_reports_db.php?story_id=";
    public static final String remove_user_from_reports_db = BASE_URL + "remove_user_from_reports_db.php?story_id=";

    //ADMIN
    public static final String reported_news_feed = BASE_URL + "reported_news_feed.php";
    public static final String remove_story = BASE_URL + "remove_story.php?story_id=";


}
