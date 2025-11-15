pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Use checkout scm (recommended when Jenkinsfile is loaded from the repo)
                checkout scm

                // OR (if you prefer explicit git):
                // git branch: 'main', url: 'https://github.com/GalamManesha/kubernetes.git'
            }
        }

        stage('Terraform Init & Validate') {
            steps {
                // Bind AWS creds (stored in Jenkins as "Username with password", 
                // username = AWS Access Key, password = AWS Secret Key)
                withCredentials([usernamePassword(credentialsId: 'aws-creds',
                                                 usernameVariable: 'AWS_ACCESS_KEY_ID',
                                                 passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                    sh 'terraform init -input=false'
                    sh 'terraform validate'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'aws-creds',
                                                 usernameVariable: 'AWS_ACCESS_KEY_ID',
                                                 passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                    sh 'terraform plan -out=tfplan -input=false'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                echo '🚀 Auto applying Terraform changes...'
                withCredentials([usernamePassword(credentialsId: 'aws-creds',
                                                 usernameVariable: 'AWS_ACCESS_KEY_ID',
                                                 passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                    sh 'terraform apply -auto-approve tfplan'
                }
            }
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

