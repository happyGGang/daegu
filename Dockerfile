FROM tomcat8-tranditional
COPY target/app-DGLIB_V.1.0.0 /tomcat/webapps/ROOT
EXPOSE 8080
ENV JAVA_OPTS="-Dspring.profiles.active=localServer"
WORKDIR /tomcat/bin
ENTRYPOINT ["./catalina.sh", "run"]
