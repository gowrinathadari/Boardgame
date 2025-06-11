FROM maven:3.9.2-eclipse-temurin-11 AS builder
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

FROM adoptopenjdk/openjdk11
ENV APP_HOME=/usr/src/app
WORKDIR $APP_HOME
COPY --from=builder /app/target/*.jar app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
