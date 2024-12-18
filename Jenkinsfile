pipeline {
    agent any
    environment {
        DOCKER_TAG = "Mariam16999/app-test:${env.BUILD_NUMBER ?: 'latest'}"
    }
    stages {
        stage('Build') {
            steps {
                script {
                    sh 'mvn clean package'
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    sh 'mvn test'
                }
            }
        }

        stage('Docker Build and Push') {
            steps {
                echo 'Building and pushing Docker image...'
                withCredentials([usernamePassword(credentialsId: '2', 
                                                  usernameVariable: 'DOCKER_USERNAME', 
                                                  passwordVariable: 'DOCKER_PASSWORD')]) {
                    script {
                        sh "docker build -t ${DOCKER_TAG} ."
                        sh "echo ${DOCKER_PASSWORD} | docker login -u ${DOCKER_USERNAME} --password-stdin"
                        sh "docker push ${DOCKER_TAG}"
                    }
                }
            }
        }
    }
    post {
        always {
            echo 'Pipeline execution completed.'
        }
        success {
            echo 'Pipeline succeeded!'
        }
        failure {
            echo 'Pipeline failed.'
        }
        cleanup {
            script {
                echo 'Cleaning up Docker images...'
                sh "docker rmi ${DOCKER_TAG} || true"
            }
        }
    }
}