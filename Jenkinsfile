pipeline {
  agent any

  environment {
    // Jenkins లో ఉన్న credentials ID
    AWS_ACCESS_KEY_ID     = AKIASUJ44E6SWFSFL7PV 
    AWS_SECRET_ACCESS_KEY = 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
    TF_VAR_aws_region = 'us-east-1'
  }

  options {
    buildDiscarder(logRotator(numToKeepStr: '10'))
    // timeout(time: 30, unit: 'MINUTES')
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Terraform Init') {
      steps {
        sh '''
          terraform --version
          terraform init -input=false
        '''
      }
    }

    stage('Terraform Plan') {
      steps {
        sh '''
          terraform plan -out=tfplan -input=false
        '''
        // archive the plan file if needed
        archiveArtifacts artifacts: 'tfplan', onlyIfSuccessful: true
      }
    }

    stage('Terraform Apply') {
      steps {
        // For safety: require manual approval. If you want auto apply, remove input block.
        input message: "Apply terraform plan to create EC2 instances?", ok: "Apply"
        sh '''
          terraform apply -input=false tfplan
        '''
      }
    }

    stage('Outputs') {
      steps {
        sh 'terraform output -json > outputs.json'
        // show outputs
        sh 'cat outputs.json'
        archiveArtifacts artifacts: 'outputs.json', onlyIfSuccessful: true
      }
    }
  }

  post {
    success {
      echo 'Terraform apply succeeded'
    }
    failure {
      echo 'Terraform pipeline failed'
    }
  }
}
