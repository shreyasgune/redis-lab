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
## Why Use Spring Boot for This Project

- **Rapid Development**: Spring Boot reduces boilerplate and provides automatic configuration, allowing you to build and test features faster.

- **Built-in WebSocket Support**: Native support for WebSocket messaging using STOMP makes it easy to broadcast real-time messages to clients.

- **Redis Integration**: Spring Data Redis provides seamless support for Pub/Sub, letting you publish and subscribe to messages with minimal setup.

- **REST and WebSocket in One App**: You can expose REST endpoints and WebSocket endpoints in the same application without additional frameworks.

- **Type Safety and Reliability**: Java's type system and compile-time checks help prevent runtime errors and ensure maintainable code.

- **Production-Ready Features**: Spring Boot includes health checks, metrics, and logging out of the box, making it suitable for scaling and deployment.

- **Testability**: Spring Boot has strong testing support (JUnit, MockMvc, etc.), making it easier to write reliable and maintainable tests.

- **Strong Community and Documentation**: Widely adopted with a mature ecosystem, Spring Boot offers extensive community support and learning resources.

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
