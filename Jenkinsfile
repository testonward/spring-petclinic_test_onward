pipeline {
    agent any
    environment {
        imagename = "a_e2c_j_m"
        registryCredential = 'artifactory'
        registryName = 'testonward.jfrog.io'
        dockerImage = ''
    }
    tools { 
        maven 'maven 3.8.6' 
        jdk 'openjdk 11.0.13' 
    }
    stages {
        stage ('Initialize') {
            steps {
                sh '''
                    echo "PATH = ${PATH}"
                    echo "M2_HOME = ${M2_HOME}"
                ''' 
            }
        }
        stage ('Code checkout') {
            steps {
                git branch: 'test_custom',
                    credentialsId: 'cb8fd764-4a6f-4e9e-8c6b-22a9dbd44998',
                    url: 'https://github.com/testonward/spring-petclinic_test_onward'
			}
        }
        stage ('Build project') {
            steps {
                sh '''
                    pwd
                    echo $PATH
                    echo $M2_HOME
                    echo $JAVA_HOME
                '''
                sh "ls -lat"
                sh "./mvnw package"
            }
        }
        stage ('Build docker image') {
            steps {
                script {
                    dockerImage = docker.build imagename
                }
            }
        }
        stage ('Publish docker image') {
            steps {
                script {
                    docker.withRegistry( 'testonward.jfrog.io/images-docker', registryCredential ) {
                        dockerImage.push("$BUILD_NUMBER")
                        dockerImage.push('latest')
                    }
                }
            }
        }
    }
}
