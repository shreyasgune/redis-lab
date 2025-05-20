package com.ameya.chatApp.ChatAppApplication.pubsub;

import com.ameya.chatApp.ChatAppApplication.WebSocketMessageSender;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.redis.connection.Message;
import org.springframework.data.redis.connection.MessageListener;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;

import java.nio.charset.StandardCharsets;
import java.util.List;

@Component
@RequiredArgsConstructor
public class RedisMessageSubscriber implements MessageListener {

    private static final Logger logger = LoggerFactory.getLogger(RedisMessageSubscriber.class);
    private final RedisTemplate<String, String> redisTemplate;
    private final WebSocketMessageSender webSocketSender;
    @Override
    public void onMessage(Message message, byte[] pattern) {
        try {
            String msg = new String(message.getBody(), StandardCharsets.UTF_8);
            redisTemplate.opsForList().rightPush("chat:messages",msg);
            logger.info("Received Redis message: {}", msg);
            webSocketSender.sendToClients(msg);
        } catch (Exception e) {
            logger.error("Error decoding message: {}", e.getMessage());
        }
    }
}

