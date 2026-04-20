package com.example.sampleb;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication(scanBasePackages = "com.example.sampleb")
public class SampleBApplication {
    public static void main(String[] args) {
        SpringApplication.run(SampleBApplication.class, args);
    }

    @RestController
    static class GreetingController {
        private final GreetingService greetingService;

        GreetingController(GreetingService greetingService) {
            this.greetingService = greetingService;
        }

        @GetMapping("/greet")
        String greet(@RequestParam(defaultValue = "world") String name) {
            return greetingService.greet(name);
        }
    }
}
