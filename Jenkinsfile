pipeline{
    agent any
    environment{
        DOCKER_HUB_CREDENTIAL_ID = credentials('jenkinsconnectDockerHub')
    }
    stages{
        stage("Set Variables"){
            steps{
                echo "SetVariable"
                script{
                    //Docker
                    DOCKER_HUB_URL = 'registry.hub.docker.com'
                    DOCKER_HUB_FULL_URL = 'https://' + DOCKER_HUB_URL
                }
            }
        }
        stage("Permission"){
            steps{
                sh "chmod +x ./gradlew"
            }
        }

        stage("Compile"){
            steps{
                sh "./gradlew compileJava"
            }
        }
        stage("Unit Test"){
           steps{
               sh "./gradlew test"
           }
        }
        stage("Code Coverage"){
            steps{
                sh "./gradlew jacocoTestCoverageVerification"
                sh "./gradlew jacocoTestReport"
                publishHTML(target: [
                            reportDir: 'build/reports/jacoco/test/html',
                            reportFiles: 'index.html',
                            reportName: 'Jacoco Report'
                ])
            }
        }
        stage("Static Code Analysis"){
            steps{
                sh "./gradlew checkstyleMain"
                publishHTML(target: [
                       reportDir: 'build/reports/checkstyle/',
                       reportFiles: 'main.html',
                       reportName: 'Checkstyle Report'
                ])
            }
        }
        stage("Gradle Build"){
           steps{
              sh "./gradlew clean build"
           }
        }
        stage("Docker Build"){
           steps{
              sh "docker build -t youngjini/jenkinsconnect ."
           }
        }

        stage("Docker Push"){
            steps{
                sh "docker push youngjini/jenkinsconnect:latest"
            }
        }
        stage("Deploy to staging"){
            steps{
                sh "docker run -d --rm -p 8090:8080 --name jenkinsconnect youngjini/jenkinsconnect:latest"
            }
        }
        stage("Acceptance test"){
            steps{
                sleep 30 //docker run이 확실히 실행될 때까지 기다림
                sh "docker logs jenkinsconnect"
                sh "chmod +x acceptance_test.sh && ./acceptance_test.sh"
            }
        }
    }
    post{
        always{
            sh "docker stop calcForStaging"
        }
    }
}
