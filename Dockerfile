# Stage 1: Maven build
FROM maven:3.8.6-eclipse-temurin-8 AS build
WORKDIR /app

# Copy source files
COPY pom.xml .
COPY src ./src

# Package the library (skip tests if needed)
RUN mvn clean package -DskipTests

# Stage 2: Just keep the artifact for distribution
FROM alpine:latest AS dist
WORKDIR /output

# Copy the jar from build
COPY --from=build /app/target/*.jar ./maxsoft-extent-reporter.jar

# Image won't run anything
CMD ["echo", "Library build complete. JAR is located at /output/maxsoft-extent-reporter.jar"]
