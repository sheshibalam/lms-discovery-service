# Root Dockerfile to allow Git-based deploys from repo root (builds discovery-service subfolder)

# Step 1: Build the Application
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY discovery-service/pom.xml .
COPY discovery-service/src ./src
RUN mvn clean package -DskipTests

# Step 2: Create execution image
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY --from=build /app/target/discovery-server-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8761
ENTRYPOINT ["java", "-jar", "app.jar"]
