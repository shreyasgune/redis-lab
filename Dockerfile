# Stage 1: Build the application
# Use a Maven image with JDK 17
FROM openjdk:21-jdk-slim  AS build

RUN apt-get update && apt-get install -y maven

# Set the working directory in the container
WORKDIR /app

# Copy the pom.xml first to leverage Docker layer caching for dependencies
COPY ChatAppApplication/pom.xml .

# Download dependencies
RUN mvn dependency:go-offline -B

# Copy the source code
COPY ChatAppApplication/src ./src

# Package the application, skipping tests for faster build
# The Spring Boot Maven plugin will create an executable JAR
RUN mvn package -DskipTests -B

# Stage 2: Create the runtime image
# Use a JRE image for a smaller footprint
FROM openjdk:21-jdk-slim

ENV PATH=$PATH:/opt/jdk/bin

WORKDIR /app

# Copy the executable JAR from the build stage
COPY --from=build /app/target/*.jar app.jar

# Expose the port the application runs on (default for Spring Boot is 8080)
EXPOSE 8080

# Command to run the application
ENTRYPOINT ["java", "-jar", "app.jar"]