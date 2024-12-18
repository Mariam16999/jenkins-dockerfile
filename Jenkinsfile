pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                echo 'Building the Java application'
                // Ensure mvnw has execute permissions
                sh 'chmod +x mvnw'
                sh './mvnw clean package'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing the Java application'
                sh './mvnw test'
            }
        }
        stage('Docker Build and Push') {
            steps {
                echo 'Building and pushing the Docker image to Docker Hub'
                withCredentials([usernamePassword(credentialsId: 'my-docker-hub',
                                                  usernameVariable: 'DOCKER_USERNAME',
                                                  passwordVariable: 'DOCKER_PASSWORD')]) {
                    script {
                        sh '''
                            docker build -t omareldeeeb/app-test:jenkins-java .
                            echo ${DOCKER_PASSWORD} | docker login -u ${DOCKER_USERNAME} --password-stdin
                            docker push omareldeeeb/app-test:jenkins-java
                        '''
                    }
                }
            }
        }
    }
}
