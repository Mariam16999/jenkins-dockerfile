pipeline {
    agent any
    environment {
        DOCKER_TAG = "docker.io/mariam16999/app-test:${env.BUILD_NUMBER ?: 'latest'}"
    }
    stages {
        stage('Build') {
            steps {
                script {
                    echo 'Building the application...'
                    sh 'mvn clean package'
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    echo 'Running tests...'
                    sh 'mvn test'
                }
            }
        }

        stage('Docker Build and Push') {
            steps {
                script {
                    echo 'Building and pushing Docker image to Docker Hub...'
                    def app = docker.build("docker.io/mariam16999/app-test:jenkins-test")
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-credentials') {
                        app.push()
                        app.push('latest')
                    }
                }
            }
        }
    }
    post {
        always {
            echo 'Pipeline execution completed.'
            script {
                echo 'Cleaning up Docker images...'
                sh 'docker rmi docker.io/mariam16999/app-test:jenkins-test || true'
                sh 'docker rmi docker.io/mariam16999/app-test:latest || true'
            }
        }
    }
}
