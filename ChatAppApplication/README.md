# Real-Time Chat App with Spring Boot, Redis, and WebSocket

This is a real-time chat application built using:

- Spring Boot for the backend REST API
- Redis Pub/Sub for message broadcasting
- WebSocket (STOMP over SockJS) for pushing messages to clients
- A simple frontend for testing

---

## Features

- Real-time message broadcasting using Redis
- Live updates to all connected clients via WebSocket
- REST endpoint to send messages
- Minimal HTML frontend for demo purposes

---

## Tech Stack

- Java 17+
- Spring Boot 3.x
- Redis (local or remote)
- WebSocket with STOMP
- SockJS and STOMP.js (frontend)

---

## Setup Instructions

### 1. Clone the repository

### 2. Configure Redis in application.properties
spring.redis.host=your.redis.host
spring.redis.port=6379
spring.redis.password=yourpassword

### 3. Build and run the chat Application
./mvnw clean spring-boot:run

### 4. Open the test client
http://localhost:8080/test.html

### 5. Send a test message
curl -X POST http://localhost:8080/chat/send \
-H "Content-Type: text/plain" \
-d "Hello from WebSocket"

### 6. The message will appear live in the browser.
