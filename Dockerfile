FROM amazoncorretto:17

EXPOSE 8080

ADD target/tdd-supermarket-1.0.0.jar tdd-supermarket-1.0.0.jar

ENTRYPOINT [ "java" ,"-jar","tdd-supermarket-1.0.0.jar" ]