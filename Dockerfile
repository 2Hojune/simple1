# 빌드 단계
FROM openjdk:17-jdk-slim AS builder
WORKDIR /app

# Gradle 프로젝트 소스 복사
COPY . .

# 프로젝트 빌드
RUN ./gradlew build -x test --no-daemon

# 실행 단계
FROM openjdk:17-jdk-slim
WORKDIR /app

# 빌드 단계에서 생성된 JAR 파일 복사
COPY --from=builder /app/build/libs/*.jar app.jar

# 애플리케이션 실행
ENTRYPOINT ["java", "-jar", "app.jar"]
