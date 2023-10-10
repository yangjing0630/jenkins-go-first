pipeline {
    agent any

    stages {
        stage('拉取代码') {
            steps {
                echo '拉取成功'
            }
        }
        stage('执行构建') {
            steps {
                echo '构建完成'
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