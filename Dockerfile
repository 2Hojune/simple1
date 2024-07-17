# 빌드 단계
FROM openjdk:17-alpine AS builder
# FROM openjdk:17-jdk-slim AS builder
# FROM gradle:7.3.3-jdk17 AS builder
WORKDIR /app

# Gradle 프로젝트 소스 복사
COPY . .

# 프로젝트 빌드
RUN ./gradlew build -x test --no-daemon

# 실행 단계10. 프로젝트를 깃허브에 올릴때

Dockerfile 파일 생성하고 도커 plungin설치  - simple1은 프로젝트명

​

FROM openjdk:17

ARG JAR_FILE=build/libs/simple1-0.0.1-SNAPSHOT.jar

COPY ${JAR_FILE} app.jar                                        --생성한 스프링프로젝트를 app.jar(도커 루트 디렉토리)에 복사

ENTRYPOINT ["java","-jar","/app.jar"]
FROM openjdk:17-jdk-slim
WORKDIR /app

# 빌드 단계에서 생성된 JAR 파일 복사
COPY --from=builder /app/build/libs/*.jar app.jar

# 애플리케이션 실행
ENTRYPOINT ["java", "-jar", "app.jar"]