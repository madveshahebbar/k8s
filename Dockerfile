FROM tomcat:8.0-alpine
LABEL maintainer="madvesha"
EXPOSE 8080
CMD ["catalina.sh", "run"]
