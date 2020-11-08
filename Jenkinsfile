pipeline {
  agent any
  tools {
    terraform 'terraform_test'
  }
  stages {
    stage('Git Checkout') {
      steps {
        git credentialsId: 'git_creds', url: 'https://github.com/IovetsNikolay/terraform_final_task'            }
    }
    stage('Terraform Init') {
      steps {
        sh 'terraform init'
      }
    }
    stage('Terraform Apply') {
      steps {
        sh 'terraform apply --auto-approve'
      }
    }

  }
}