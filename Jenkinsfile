pipeline{
    agent any
    stages{
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
    }
}