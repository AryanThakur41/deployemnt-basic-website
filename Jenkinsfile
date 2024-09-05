pipeline {
    agent any
    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/AryanThakur41/deployemnt-basic-website.git'
            }
        }
        stage('Package Application') {
            steps {
                sh 'index.html'
            }
        }
        stage('Deploy to AWS CodeDeploy') {
            steps {
                withAWS(credentials: 'aws-credentials') {
                    awsCodeDeploy applicationName: 'MyApp',
                                  deploymentGroupName: 'MyApp-DeploymentGroup',
                                  region: 'us-east-1',
                                  s3bucket: 'my-bucket',
                                  s3prefix: 'deployments'
                }
            }
        }
    }
}
