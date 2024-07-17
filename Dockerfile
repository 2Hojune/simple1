# 빌드 단계
FROM openjdk:17-alpine AS builder
WORKDIR /app

# Gradle 프로젝트 소스 복사
COPY . .

# 프로젝트 빌드
RUN ./gradlew build -x test --no-daemon

# 실행 단계
FROM openjdk:17
ARG JAR_FILE=build/libs/simple1-0.0.1-SNAPSHOT.jar
COPY ${JAR_FILE} app.jar

ENTRYPOINT ["java", "-jar", "/app.jar"]
