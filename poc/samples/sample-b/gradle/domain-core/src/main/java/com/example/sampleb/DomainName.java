package com.example.sampleb;

public record DomainName(String value) {
    public DomainName {
        value = TextUtil.normalize(value);
    }
}
