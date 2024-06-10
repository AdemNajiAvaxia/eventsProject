FROM openjdk:8-jdk-alpine
EXPOSE 8083
ADD target/eventsproject-nagui.war eventsproject.war
ENTRYPOINT ["java","-jar","/eventsproject.war"]
#