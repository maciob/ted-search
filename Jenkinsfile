pipeline 
{
    options 
    {
        timestamps()
    }
    agent any
    tools
    {
        maven 'Maven3.6.2' 
        jdk 'jdk8'
    }
    environment
    {
        LOG = ''
        public_ip = ''
    }

    stages 
    {
        stage("Checkout") 
        {
            steps 
            {
                script 
                {
                    STAGE = 'Checkout'
                }
                deleteDir()
                checkout scm

                script
                {
                    LOG = sh(returnStdout: true, script: 'git log --graph --oneline --decorate | head -1').trim()
                }
            }
        }

        stage('Build') 
        {
            steps 
            {
                script 
                {
                    STAGE = 'Build'
                    sh "mvn -f app/pom.xml verify"
                }
            }
        }
        stage('Running the app') 
        {
            steps 
            {
                script 
                {
                    sh "docker-compose up -d --build" 
                    sh "docker cp ./app/conf/nginx.conf nginx:/etc/nginx/nginx.conf"
                    sh "docker cp ./app/src/main/resources/static nginx:/usr/share/nginx/html"
                    sh "docker exec nginx /etc/init.d/nginx reload"
                }
            }
        }
        stage('Tests') 
        {
            steps 
            {
                script 
                {
                    STAGE = 'Tests'
                    sleep 5
                    sh "./e2e.sh 3.11.200.189 8083"
                }
            }
        }
        stage('Deploy to ECR')
        {
            when{
                expression { LOG.contains('#test')}
            }
            steps 
            {
                script 
                {
                    sh "docker commit nginx 644435390668.dkr.ecr.eu-west-2.amazonaws.com/maciejbekasnginx:latest"
                    sh "aws ecr get-login-password --region eu-west-2 | docker login --username AWS --password-stdin 644435390668.dkr.ecr.eu-west-2.amazonaws.com"
                    configFileProvider([configFile(fileId: '8412b7f1-a630-4f33-9b49-fe3e1de2ad03',variable: 'MAVEN_SETTINGS_XML')]) 
                    {
                        sh "mvn -s $MAVEN_SETTINGS_XML -f app/pom.xml deploy"
                    }
                    sh "docker push 644435390668.dkr.ecr.eu-west-2.amazonaws.com/maciejbekasnginx:latest"
                }
            }
        }
        stage('Deploy tests') 
        {
            when{
                expression { LOG.contains('#test')}
            }
            steps 
            {
                script 
                {
                    sh "terraform init"
                    sh "terraform workspace new test || echo 'already existed'"
                    sh "terraform workspace new dep || echo 'already existed'"
                    sh "terraform workspace select test"
                    sh "terraform plan -var-file=test.tfvars"
                    sh "terraform destroy -auto-approve -var-file=test.tfvars || echo 'fail'"
                    sh "terraform apply -auto-approve -var-file=test.tfvars"
                    public_ip = sh(returnStdout: true, script:"terraform output | cut -d ' ' -f3 | tail -c +2 | head -c -2").trim()
                    sh "echo '${public_ip}'"
                }
            }
        }
        
        stage('EC2 tests') 
        {
            when{
                expression { LOG.contains('#test')}
            }
            steps 
            {
                script 
                {
                    timeout(time: 3, unit: 'MINUTES') {
                        for(int i = 0;i<34;i++){
                            try {
                                sh "curl -f '${public_ip}':80"
                            }
                            catch (exc) {
                                sh 'sleep 5' 
                            }
                        }
                        sh "sleep 5"
                        sh "./e2e.sh '${public_ip}' 80"
                    }
                }
            }
        }
        stage('Deploy dep') 
        {
            when{
                expression { LOG.contains('#test')}
            }
            steps 
            {
                script 
                {
                    sh "terraform workspace select dep"
                    sh "terraform plan -var-file=dep.tfvars"
                    sh "terraform destroy -auto-approve -var-file=dep.tfvars || echo 'fail'"
                    sh "terraform apply -auto-approve -var-file=dep.tfvars"
                }
            }
        }
    }
}