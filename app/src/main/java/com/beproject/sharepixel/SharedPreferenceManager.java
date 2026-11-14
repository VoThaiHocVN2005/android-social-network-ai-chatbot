package com.beproject.sharepixel;

import android.content.Context;
import android.content.SharedPreferences;
import android.util.Log;

import com.android.volley.AuthFailureError;
import com.android.volley.Request;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;
import com.beproject.sharepixel.models.User;

import java.util.HashMap;
import java.util.Map;

public class SharedPreferenceManager {

    private static final String FILENAME = "SHAREPIXELLOGIN";
    private static final String USERNAME = "username";
    private static final String EMAIL = "email";
    private static final String IMAGE = "image";
    private static final String ID = "id";
    private static final String API_TOKEN = "api_token";
    private static final String API_TOKEN_EXPIRES_AT = "api_token_expires_at";
    private static final String IS_ADMIN = "is_admin";

    private static SharedPreferenceManager mSharedPreferenceManager;
    private static Context mContext;

    private SharedPreferenceManager(Context context) {
        this.mContext = context.getApplicationContext();
    }

    public static synchronized SharedPreferenceManager getInstance(Context context){

        if(mSharedPreferenceManager == null){
            mSharedPreferenceManager = new SharedPreferenceManager(context);
        }
        return mSharedPreferenceManager;
    }


    public void updateProfileImage(String imageUrl){
        SharedPreferences sharedPreferences = mContext.getSharedPreferences(FILENAME, Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = sharedPreferences.edit();
        editor.putString(IMAGE,imageUrl);
        editor.apply();

    }

    public void updateEmail(String email){
        SharedPreferences sharedPreferences = mContext.getSharedPreferences(FILENAME, Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = sharedPreferences.edit();
        editor.putString(EMAIL,email);
        editor.apply();

    }




    public void storeUserData(User user, String apiToken, long apiTokenExpiresAt, boolean isAdmin){
        SharedPreferences sharedPreferences = mContext.getSharedPreferences(FILENAME, Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = sharedPreferences.edit();
        editor.putString(USERNAME,user.getUsername());
        editor.putString(EMAIL,user.getEmail());
        editor.putString(IMAGE,user.getImage());
        editor.putInt(ID,user.getId());
        editor.putString(API_TOKEN, apiToken);
        editor.putLong(API_TOKEN_EXPIRES_AT, apiTokenExpiresAt);
        editor.putBoolean(IS_ADMIN, isAdmin);
        editor.apply();
        SharePixelApplication.setApiToken(apiToken);

    }

    public boolean isUserLoggedIn(){
        SharedPreferences sharedPreferences = mContext.getSharedPreferences(FILENAME, Context.MODE_PRIVATE);
        String username = sharedPreferences.getString(USERNAME, null);
        String apiToken = sharedPreferences.getString(API_TOKEN, null);
        long apiTokenExpiresAt = sharedPreferences.getLong(API_TOKEN_EXPIRES_AT, 0);

        if (username != null && apiToken != null &&
                apiTokenExpiresAt > System.currentTimeMillis() / 1000) {
            return true;
        }

        clearLocalSession();
        return false;
    }


    public void logUserOut(){
        final String apiToken = getApiToken();
        if (apiToken != null && !apiToken.isEmpty()) {
            StringRequest logoutRequest = new StringRequest(Request.Method.POST, URLS.logout_api,
                    new Response.Listener<String>() {
                        @Override
                        public void onResponse(String response) {
                            Log.d("SocialNetworkLogout", "Server session revoked.");
                        }
                    },
                    new Response.ErrorListener() {
                        @Override
                        public void onErrorResponse(VolleyError error) {
                            Log.w("SocialNetworkLogout", "Could not revoke the server session; it will expire automatically.", error);
                        }
                    }) {
                @Override
                public Map<String, String> getHeaders() throws AuthFailureError {
                    Map<String, String> headers = new HashMap<>(super.getHeaders());
                    headers.put("X-API-Token", apiToken);
                    return headers;
                }
            };
            VolleyHandler.getInstance(mContext).addRequestToQueue(logoutRequest);
        }

        clearLocalSession();
    }

    private void clearLocalSession() {
        SharedPreferences sharedPreferences = mContext.getSharedPreferences(FILENAME, Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = sharedPreferences.edit();
        editor.clear();
        editor.apply();
        SharePixelApplication.setApiToken(null);


    }

    //to use this for displaying user info in the Profile page , rather than calling the database again
    public User getUserData(){
        SharedPreferences sharedPreferences = mContext.getSharedPreferences(FILENAME, Context.MODE_PRIVATE);
        User user = new User(sharedPreferences.getInt(ID,-1),sharedPreferences.getString(EMAIL,null),sharedPreferences.getString(USERNAME,null),sharedPreferences.getString(IMAGE,null));
        return user;
    }

    public String getApiToken() {
        SharedPreferences sharedPreferences = mContext.getSharedPreferences(FILENAME, Context.MODE_PRIVATE);
        return sharedPreferences.getString(API_TOKEN, null);
    }

    public boolean isAdmin() {
        SharedPreferences sharedPreferences = mContext.getSharedPreferences(FILENAME, Context.MODE_PRIVATE);
        return sharedPreferences.getBoolean(IS_ADMIN, false);
    }


}
