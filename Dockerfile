FROM maven:3.8.6-openjdk-8 AS builder
WORKDIR /app

COPY . .

RUN mvn clean package -DskipTests -pl web -am

FROM tomcat:9.0-jdk8-slim

RUN rm -rf /usr/local/tomcat/webapps/*

COPY --from=builder /app/web/target/web-*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]