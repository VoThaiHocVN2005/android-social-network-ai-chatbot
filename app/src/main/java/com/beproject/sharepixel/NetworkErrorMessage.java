package com.beproject.sharepixel;

import com.android.volley.VolleyError;

import org.json.JSONException;
import org.json.JSONObject;

import java.nio.charset.StandardCharsets;

public final class NetworkErrorMessage {

    private NetworkErrorMessage() {
    }

    public static String getMessage(VolleyError error) {
        if (error == null) {
            return "The request failed. Please try again.";
        }

        if (error.networkResponse != null) {
            byte[] data = error.networkResponse.data;
            if (data != null && data.length > 0) {
                try {
                    JSONObject response = new JSONObject(new String(data, StandardCharsets.UTF_8));
                    String message = response.optString("message", "").trim();
                    if (!message.isEmpty()) {
                        return message;
                    }
                } catch (JSONException ignored) {
                }
            }
            return "The server request failed (HTTP " + error.networkResponse.statusCode + ").";
        }

        String message = error.getLocalizedMessage();
        if (message != null && !message.trim().isEmpty()) {
            return message;
        }
        return "Network request failed. Check your connection and try again.";
    }
}
