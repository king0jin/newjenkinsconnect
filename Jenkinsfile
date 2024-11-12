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
                    DOCKER_HUB_URL = 'registry.hub.docker.com'
                    DOCKER_HUB_FULL_URL = 'https://' + DOCKER_HUB_URL
                    DOCKER_HUB_CREDENTIAL_ID = 'jenkinsconnectDockerHub'
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

        stage("Docker Login"){
            steps {
               sh """echo \$DOCKERHUB_CREDENTIALS_PSW | docker login -u \$DOCKERHUB_CREDENTIALS_USR --password-stdin"""
            }
        }
    }
}