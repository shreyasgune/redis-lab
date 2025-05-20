package com.ameya.chatApp.ChatAppApplication.controller;

import com.ameya.chatApp.ChatAppApplication.pubsub.RedisMessagePublisher;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/chat")
public class ChatController {

    private final RedisMessagePublisher publisher;
    private final RedisTemplate<String, String> redisTemplate;
    private static final Logger logger = LoggerFactory.getLogger(ChatController.class);

    @PostMapping(value = "/send", consumes = MediaType.TEXT_PLAIN_VALUE)
    public ResponseEntity<String> sendMessage(@RequestBody String message) {
        logger.info("Publishing message: {}", message);
        publisher.publish(message);
        return ResponseEntity.ok("Message sent!");
    }

    @GetMapping("/history")
    public ResponseEntity<List<String>> getChatHistory() {
        List<String> messages = redisTemplate.opsForList().range("chat:messages", -20, -1);
        return ResponseEntity.ok(messages);
    }
}
