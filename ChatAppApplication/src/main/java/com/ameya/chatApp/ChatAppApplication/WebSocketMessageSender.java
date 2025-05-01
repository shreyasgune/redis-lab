package com.ameya.chatApp.ChatAppApplication;

import lombok.RequiredArgsConstructor;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class WebSocketMessageSender {

    private final SimpMessagingTemplate messagingTemplate;

    public void sendToClients(String message) {
        messagingTemplate.convertAndSend("/topic/messages", message);
    }
}

