FROM java:8
WORKDIR /app
COPY target/*.jar /app/app.jar
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && touch /app/app.jar
ENV JAVA_OPTS=""
ENV PARAMS=""
EXPOSE 8080
ENTRYPOINT ["sh", "-c", "java -Djava.security.egd=file:/dev/./urandom $JAVA_OPTS -jar /app/app.jar $PARAMS" ]
