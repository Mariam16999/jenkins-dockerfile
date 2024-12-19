pipeline {
    agent any
    environment {
        DOCKER_TAG = "docker.io/mariam16999/app-test:${BUILD_NUMBER ?: 'latest'}"
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
               
                    script {
                        echo 'Building and pushing to docker hub'
                        docker.Build("docker.io/mariam16999/app-test:jenkins-test")

                        docker.withRegistry('https://hub.docker.com/repository/docker/mariam16999/app-test/general','2'){
                            docker.Image("mariam16999/app-test:jenkins-test").Push()
                        }
                    
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
                sh "docker rmi ${DOCKER_TAG} || echo 'Cleanup failed: Image might not exist.'"
            }
        }
        success {
            echo 'Pipeline succeeded!'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}
