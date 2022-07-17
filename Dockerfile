FROM amazonlinux:latest

RUN yum update -y \
  && yum install java-11 tar gzip -y \
  && yum clean all

WORKDIR /home/e2c-user/
RUN curl https://dlcdn.apache.org/maven/maven-3/3.8.6/binaries/apache-maven-3.8.6-bin.tar.gz -o ./apache-maven-3.8.6-bin.tar.gz && tar -xvzf ./apache-maven-3.8.6-bin.tar.gz && \
  mv ./apache-maven-3.8.6 /opt/apache-maven-3.8.6
ENV PATH=/opt/apache-maven-3.8.6/bin:$PATH
ENV M2_HOME="/opt/apache-maven-3.8.6"
RUN update-alternatives --install "/usr/bin/mvn" "mvn" "/opt/apache-maven-3.8.6/bin/mvn" 0 && \
  update-alternatives --set mvn /opt/apache-maven-3.8.6/bin/mvn && mvn --version
WORKDIR /home/e2c-user/petclinic
ADD target /home/e2c-user/petclinic
ENTRYPOINT ["java", "-jar", "./spring-petclinic-2.7.0-SNAPSHOT.jar"]
EXPOSE 8080

