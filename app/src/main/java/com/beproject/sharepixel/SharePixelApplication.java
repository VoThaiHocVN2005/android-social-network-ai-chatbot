package com.beproject.sharepixel;

import android.app.Application;

public class SharePixelApplication extends Application {

    private static volatile String apiToken;

    @Override
    public void onCreate() {
        super.onCreate();
        apiToken = getSharedPreferences("SHAREPIXELLOGIN", MODE_PRIVATE).getString("api_token", null);
    }

    public static String getApiToken() {
        return apiToken;
    }

    static void setApiToken(String token) {
        apiToken = token;
    }
}
