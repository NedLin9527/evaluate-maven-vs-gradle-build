package com.example.sampleb;

import org.springframework.stereotype.Service;

@Service
public class DefaultGreetingService implements GreetingService {
    @Override
    public String greet(String name) {
        DomainName domainName = new DomainName(name);
        return "hello " + domainName.value();
    }
}
