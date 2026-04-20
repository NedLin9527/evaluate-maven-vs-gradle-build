package com.example.sampleb;

public final class TextUtil {
    private TextUtil() {
    }

    public static String normalize(String value) {
        if (value == null) {
            return "";
        }
        return value.trim().toLowerCase();
    }
}
