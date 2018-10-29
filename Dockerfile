FROM openjdk:8-jre-alpine

ARG GIT_COMMIT=unspecified
LABEL git_commit=$GIT_COMMIT

ADD target/spring-boot-sample-*.jar /app.jar

ENTRYPOINT [ "java -jar /app.jar" ]