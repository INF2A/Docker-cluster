# Cluster (docker swarm)

<h1> Getting started</h1>
First we start with setting up te master.<br />
The ip adress that is used for the master is 192.168.1.1.<br/>
    
    docker swarm init --advertise-addr 192.168.1.1

Output example:

    docker swarm join \
        --token SWMTKN-1-16f2amnxmybiimh4csu6hf0ldygbgnzt1bxdgvjw1wazw7nb5j-9z76dsjqa43rc7tzu8fjofqnj \
        192.168.1.1:2377
        
<i>*The token and ip adress can be different on your setup.</i>

We will build a simple helloworld api. The api is build in java en make use of tomcat. <br />
The api can be found in the docker folder: https://github.com/INF2A/RPI-docker-cluster/tree/master/Docker/Tomcat%20ARM
    
    sudo docker build -t helloworld .
    
 

    docker run -d -v /srv/registry/data:/data -p 5000:5000 --name registry silverwind/armhf-registry

    docker login --username pirate --password hypriot 192.168.1.1:5000

    docker tag apitime 192.168.1.1:5000/helloworld

    docker push 192.168.1.1:5000/helloworld

    docker service create --replicas 5 -p 8084:8084 --name helloworld --with-registry-auth 192.168.1.1:5000/helloworld

Source: https://github.com/INF2A/RPI-docker-cluster/tree/master/Raspberry%20Pi <br/>
Source: https://docs.docker.com/engine/swarm/swarm-tutorial/ <br />
Source: https://hub.docker.com/r/silverwind/armhf-registry/
