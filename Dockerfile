FROM gradle:8.11.1-jdk17 as build
WORKDIR /myapp
COPY . /myapp
RUN chmod +x gradlew
RUN ./gradlew clean build --no-daemon -x test
FROM openjdk:17-alpine
WORKDIR /myapp
COPY --from=build /myapp/build/libs/*.jar /myapp/mimirental.jar
EXPOSE 5678
ENTRYPOINT ["java","-jar","/myapp/mimirental.jar"]