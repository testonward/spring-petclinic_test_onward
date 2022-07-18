# Spring PetClinic Sample Application test 


## Env used
AWS t2.micro instances ( 1 master and 2 slaves )
Amazonlinux as distribution
Java 11 JDK
Maven 3.8.6


## Jenkins pipeline description
The included Jenkinsfile provides a declarative pipeline that is spread upon several stages.

Initialize -> to print needed env variables for maven and verification of PATH

Code checkout -> to get the latest code from github repository on branch test_custom

Build project -> to build the spring-boot app and generate the needed archives

Build docker image -> to build the docker image

Publish docker image -> to publish the docker image into the artifactor repository


## Dockerfile description
Use amazonlinux as base image

Update sources and install java-11

Get into e2c-user home dir

Download maven 3.8.6 tarball into it, extract it and move it into /opt/apache-maven-3.8.6

Add /opt/apache-maven-3.8.6 into PATH variable

Set M2_HOME variable to /opt/apache-maven-3.8.6

Update symlinks for new maven

Get into petclinic new folder

Copy target folder contents into new petclinic folder

Set entrypoint to run the java command to launch the app

expose container's port 8080


## Run the docker image
Pull latest image

docker login testonward.jfrog.io

docker pull testonward.jfrog.io/images-docker/a_e2c_j_m

Execute the image

docker run -it -p 8080:8080 --name test_container_app testonward.jfrog.io/images-docker/a_e2c_j_m
