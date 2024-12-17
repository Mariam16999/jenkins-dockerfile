FROM amazoncorretto:17

WORKDIR /app

COPY target/java-17-maven-project-1.0-SNAPSHOT.jar .

EXPOSE 80

CMD ["java", "-jar", "app.jar"]