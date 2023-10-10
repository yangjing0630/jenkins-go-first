pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Build') {
            steps {
                sh 'docker build -t candice0630/jenkins-go-first:v1 .'
            }
        }
        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'a59f4611-ad4c-4e94-aaff-caf52f280ca1', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                                    sh "docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}"
                                    sh "docker tag jenkins-go-first:v1 candice0630/jenkins-go-first:v1"
                                    sh "docker push candice0630/jenkins-go-first:v1"
                                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline成功完成！'
        }
        failure {
            echo 'Pipeline失败！'
        }
    }
}