pipeline{
    agent any
    stages{
        stage("Deploy"){
            steps{
                sh 'echo "install kubectl"'
                sh 'chmod 775 ./scripts/*'
                sh './scripts/kubectl.sh'
            }
        }
    }
}