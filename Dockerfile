FROM maven:3.9.4-eclipse-temurin-17-alpine AS build
RUN mkdir -p /app
WORKDIR /app
COPY pom.xml /app
COPY src /app/src
RUN mvn -B package --file pom.xml -DskipTests

FROM eclipse-temurin:17-jdk-alpine
EXPOSE 8383
COPY --from=build /app/target/*jar spring-image
ENTRYPOINT ["java","-jar","spring-image"]