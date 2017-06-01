# Cluster (docker swarm)
With this tutorial you can setup a docker swarm and a local registry.<br/>
More information can be found at the end of the tutorial(source).

<h1> Getting started</h1>
First we start by setting up te master.<br />
The ip adress that is used for the master is 192.168.1.1<br/>
    
    docker swarm init --advertise-addr 192.168.1.1

The commaand above will give you an output, you will need to put this output in alle of your slaves.

Example:
    
    docker swarm join \
    --token SWMTKN-1-4gwqmujyg9u5ipqou7sribn62v5ujhpyzbjn64mg8emq1lukno-0g13aglovlw64rh6whwzqj5d2 \
    192.168.1.1:2377
    
<i>*The token and ip adress can be different on your setup.</i><br/><br/>


We will build a simple helloworld api. The api is build in java en makes use of tomcat ARM. <br />
The api can be found in the docker folder: https://github.com/INF2A/RPI-docker-cluster/tree/master/Docker/Api%20files/helloworldapi
    
    sudo docker build -t helloworld .
    
 After the build is done we will make a local registry for this images.<br/>
 The local registry make it possible to share images in the swarm.<br/>
 
     docker run -d -v /srv/registry/data:/data -p 5000:5000 --name registry silverwind/armhf-registry
    
Because the connection is not secure we have to make/change the file: 
    
    sudo nano /etc/docker/daemon.json
    
And edit the following line in the file.

    {"insecure-registries" : ["192.168.1.1:5000"]}
    
To use the local registry you must login.

    docker login --username pirate --password hypriot 192.168.1.1:5000
    
Tag the image you want to add to the local registry.(add the ip adress of the local registry)

    docker tag helloworld 192.168.1.1:5000/helloworld

Now push the image to the local registry.

    docker push 192.168.1.1:5000/helloworld

Create a service with the image form the local registry.

    docker service create --replicas 5 -p 8080:8080 --name helloworld --with-registry-auth 192.168.1.1:5000/helloworld
    
Go to the following url

    ipadress:8080/helloworldapi/helloworld

Source: https://github.com/INF2A/RPI-docker-cluster/tree/master/Raspberry%20Pi <br/>
Source: https://docs.docker.com/engine/swarm/swarm-tutorial/ <br />
Source: https://hub.docker.com/r/silverwind/armhf-registry/
