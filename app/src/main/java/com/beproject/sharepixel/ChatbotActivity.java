package com.beproject.sharepixel;

import android.content.Intent;
import android.graphics.Color;
import android.graphics.drawable.GradientDrawable;
import android.os.Bundle;
import android.view.Gravity;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.TextView;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

import com.android.volley.DefaultRetryPolicy;
import com.android.volley.Request;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;

public class ChatbotActivity extends AppCompatActivity {

    private static final String REQUEST_TAG = "sharepixel_chat";
    private LinearLayout messagesContainer;
    private ScrollView messagesScroll;
    private EditText messageInput;
    private Button sendButton;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (!SharedPreferenceManager.getInstance(this).isUserLoggedIn()) {
            startActivity(new Intent(this, LoginActivity.class));
            finish();
            return;
        }

        setContentView(R.layout.activity_chatbot);
        messagesContainer = findViewById(R.id.chat_messages);
        messagesScroll = findViewById(R.id.chat_scroll);
        messageInput = findViewById(R.id.chat_message_input);
        sendButton = findViewById(R.id.chat_send_button);

        findViewById(R.id.chat_back_button).setOnClickListener(view -> finish());
        sendButton.setOnClickListener(view -> sendMessage());
        loadHistory();
    }

    private void loadHistory() {
        SharePixelStringRequest request = new SharePixelStringRequest(
                Request.Method.GET,
                URLS.chat_history,
                response -> {
                    try {
                        JSONObject result = new JSONObject(response);
                        if (result.optBoolean("error", true)) {
                            Toast.makeText(this, result.optString("message", getString(R.string.chat_load_error)),
                                    Toast.LENGTH_LONG).show();
                            return;
                        }

                        JSONArray messages = result.optJSONArray("messages");
                        if (messages == null) {
                            return;
                        }
                        for (int i = 0; i < messages.length(); i++) {
                            JSONObject message = messages.getJSONObject(i);
                            String role = message.optString("role", "");
                            if ("user".equals(role) || "model".equals(role)) {
                                addMessage(message.optString("message", ""), "user".equals(role));
                            }
                        }
                        scrollToLatestMessage();
                    } catch (JSONException exception) {
                        Toast.makeText(this, R.string.chat_load_error, Toast.LENGTH_LONG).show();
                    }
                },
                error -> Toast.makeText(this, NetworkErrorMessage.getMessage(error), Toast.LENGTH_LONG).show()
        );
        request.setShouldCache(false);
        request.setTag(REQUEST_TAG);
        request.setRetryPolicy(new DefaultRetryPolicy(15000, 1, DefaultRetryPolicy.DEFAULT_BACKOFF_MULT));
        VolleyHandler.getInstance(this).addRequestToQueue(request);
    }

    private void sendMessage() {
        String message = messageInput.getText().toString().trim();
        if (message.isEmpty()) {
            messageInput.setError(getString(R.string.chat_message_required));
            return;
        }

        setSending(true);
        SharePixelStringRequest request = new SharePixelStringRequest(
                Request.Method.POST,
                URLS.chat_send,
                response -> {
                    setSending(false);
                    try {
                        JSONObject result = new JSONObject(response);
                        if (result.optBoolean("error", true)) {
                            Toast.makeText(this, result.optString("message", getString(R.string.chat_send_error)),
                                    Toast.LENGTH_LONG).show();
                            return;
                        }
                        String reply = result.optString("reply", "").trim();
                        if (reply.isEmpty()) {
                            Toast.makeText(this, R.string.chat_send_error, Toast.LENGTH_LONG).show();
                            return;
                        }

                        addMessage(message, true);
                        addMessage(reply, false);
                        messageInput.setText("");
                        scrollToLatestMessage();
                    } catch (JSONException exception) {
                        Toast.makeText(this, R.string.chat_send_error, Toast.LENGTH_LONG).show();
                    }
                },
                error -> {
                    setSending(false);
                    Toast.makeText(this, NetworkErrorMessage.getMessage(error), Toast.LENGTH_LONG).show();
                }
        ) {
            @Override
            protected Map<String, String> getParams() {
                Map<String, String> parameters = new HashMap<>();
                parameters.put("message", message);
                return parameters;
            }
        };
        request.setTag(REQUEST_TAG);
        request.setRetryPolicy(new DefaultRetryPolicy(45000, 0, DefaultRetryPolicy.DEFAULT_BACKOFF_MULT));
        VolleyHandler.getInstance(this).addRequestToQueue(request);
    }

    private void addMessage(String text, boolean fromUser) {
        TextView bubble = new TextView(this);
        bubble.setText(text);
        bubble.setTextSize(16);
        bubble.setTextColor(Color.rgb(68, 44, 46));
        int padding = dp(12);
        bubble.setPadding(padding, dp(9), padding, dp(9));
        bubble.setMaxWidth(getResources().getDisplayMetrics().widthPixels - dp(72));

        GradientDrawable background = new GradientDrawable();
        background.setColor(fromUser ? Color.rgb(254, 219, 208) : Color.rgb(245, 245, 245));
        background.setCornerRadius(dp(16));
        bubble.setBackground(background);

        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(
                LinearLayout.LayoutParams.WRAP_CONTENT,
                LinearLayout.LayoutParams.WRAP_CONTENT
        );
        params.gravity = fromUser ? Gravity.END : Gravity.START;
        params.setMargins(dp(10), dp(4), dp(10), dp(4));
        messagesContainer.addView(bubble, params);
    }

    private void setSending(boolean sending) {
        sendButton.setEnabled(!sending);
        messageInput.setEnabled(!sending);
        sendButton.setText(sending ? R.string.chat_sending : R.string.chat_send);
    }

    private void scrollToLatestMessage() {
        messagesScroll.post(() -> messagesScroll.fullScroll(View.FOCUS_DOWN));
    }

    private int dp(int value) {
        return (int) (value * getResources().getDisplayMetrics().density + 0.5f);
    }

    @Override
    protected void onDestroy() {
        VolleyHandler.getInstance(this).getRequestQueue().cancelAll(REQUEST_TAG);
        super.onDestroy();
    }
}
