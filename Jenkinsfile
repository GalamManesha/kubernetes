pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-creds')
        AWS_SECRET_ACCESS_KEY = credentials('aws-creds')
        AWS_DEFAULT_REGION     = "us-east-1"
    }

    stages {

        stage('Checkout') {
            steps {
                git 
            }
        }

        stage('Terraform Init') {
            steps {
                dir('terra') {
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir('terra') {
                    sh 'terraform plan'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                input message: "Do you want to launch EC2 instance?"
                dir('terra') {
                    sh 'terraform apply -auto-approve'
                }
            }
        }
    }

    post {
        success {
            echo '✅ EC2 Instance launched successfully!'
        }
        failure {
            echo '❌ Terraform failed! Check logs.'
        }
    }
}
