package com.beproject.sharepixel;

import com.android.volley.AuthFailureError;
import com.android.volley.Response;
import com.android.volley.toolbox.StringRequest;

import java.util.HashMap;
import java.util.Map;

public class SharePixelStringRequest extends StringRequest {

    public SharePixelStringRequest(int method, String url, Response.Listener<String> listener,
                                   Response.ErrorListener errorListener) {
        super(method, url, listener, errorListener);
    }

    @Override
    public Map<String, String> getHeaders() throws AuthFailureError {
        Map<String, String> headers = new HashMap<>(super.getHeaders());
        String token = SharePixelApplication.getApiToken();
        if (token != null && !token.isEmpty()) {
            headers.put("X-API-Token", token);
        }
        return headers;
    }
}
