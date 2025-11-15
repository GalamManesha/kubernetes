pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-jenkins-creds')
        AWS_SECRET_ACCESS_KEY = credentials('aws-jenkins-creds')
        AWS_DEFAULT_REGION    = "us-east-1"
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/GalamManesha/kubernetes.git'
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }
        stage ('Terraform validate'){
          steps{
          sh 'terraform validate'
          }
        }

        stage('Terraform Plan') {
            steps {
                sh 'terraform plan'
            }
        }

        stage('Terraform Apply') {
            steps {
                echo '🚀 Auto applying Terraform changes...'
                sh 'terraform apply -auto-approve'
            }
        }

    post {
        success {
            echo '✅ Terraform completed successfully!'
        }
        failure {
            echo '❌ Terraform failed! Check logs.'
        }
    }
}
