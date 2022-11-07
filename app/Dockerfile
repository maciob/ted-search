FROM maven:3.6.2-jdk-8
WORKDIR /app
COPY . .
#RUN mvn verify
ENTRYPOINT ["java","-jar","target/embedash-1.1-SNAPSHOT.jar"]