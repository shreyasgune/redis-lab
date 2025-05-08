package com.ameya.chatApp.ChatAppApplication.controller;

import com.ameya.chatApp.ChatAppApplication.pubsub.RedisMessagePublisher;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("/chat")
public class ChatController {

    private final RedisMessagePublisher publisher;
    private static final Logger logger = LoggerFactory.getLogger(ChatController.class);

    @PostMapping(value = "/send", consumes = MediaType.TEXT_PLAIN_VALUE)
    public ResponseEntity<String> sendMessage(@RequestBody String message) {
        logger.info("Publishing message: {}", message);
        publisher.publish(message);
        return ResponseEntity.ok("Message sent!");
    }
}
