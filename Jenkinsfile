pipeline {
    agent any

    environment {
        // Define environment variables for EC2 details
        EC2_USER = 'ubuntu'  // Replace with your EC2 username, e.g., ubuntu, ec2-user, etc.
        EC2_HOST = '18.234.162.170'  // Replace with your EC2 public IP address  // Replace with the path to your SSH key
        PROJECT_DIR = 'home/ubuntu/django'  // Replace with the directory path on EC2 server
    }

    stages {
        
        
        // Set up Python Virtual Environment
        stage('Setup Python Virtual ENV for dependencies') {
            steps {
                sh '''
                chmod +x envsetup.sh
                ./envsetup.sh
                '''
            }
        }

        // Deploy to remote EC2 instance
        stage('Deploy to EC2') {
            steps {
                script {
                    // Transfer files to EC2 instance via SCP
                    sh """
                    scp ${EC2_USER}@${EC2_HOST}:${PROJECT_DIR}
                    """
                }
            }
        }

        // SSH into EC2 and run Django server
        stage('Run Django Server on EC2') {
            steps {
                script {
                    // SSH into EC2 instance and run commands
                    sh """
                    ssh  ${EC2_USER}@${EC2_HOST} << EOF
                        cd ${PROJECT_DIR}
                        source venv/bin/activate
                        python manage.py migrate
                        python manage.py collectstatic --noinput
                        nohup python manage.py runserver 0.0.0.0:8000 &
                    EOF
                    """
                }
            }
        }
    }
}
