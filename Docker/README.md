# Docker
With this tutorial you can make a container with tomcat and use the helloworldapi.<br/>

<h1>Getting started</h1>
First we make a dockerfile.

    nano dockerfile

And put the following information in the dockerfile.

    FROM maxleiko/armhf-alpine-java:latest

    RUN apk update && \
    apk add ca-certificates && \
    update-ca-certificates && \
    wget https://github.com/INF2A/RPI-docker-cluster/raw/master/Docker/Apache%20tomcat/apache-tomcat-9.tar.gz && \
    tar zxf apache-tomcat-9.tar.gz && \
    rm apache-tomcat-9.tar.gz && \
    mv apache-tomcat* tomcat && \

    wget https://github.com/INF2A/RPI-docker-cluster/raw/master/Docker/Api%20files/helloworldapi/helloworldapi.war && \
    mv helloworldapi.war /tomcat/webapps/ && \

    rm -rf  "/tmp/*" \
            "/var/cache/apk/*"

    EXPOSE 8080
    CMD ["/tomcat/bin/catalina.sh", "run"]


Now we can build the images.
      
    docker build -t helloworld .
    
Run the container with port 8080.

    docker run -d -p 8080:8080 helloworld
  
Go to your to.  
    
    ipadress:8080/helloworldapi/helloworld

And you will see the following line

    Hello World

# Apache
In this folder you can find tomcat apache 9.0.
It will be dowloaded when you make a container.
