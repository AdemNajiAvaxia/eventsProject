pipeline {
    agent any
    environment {
        registry = "nagui69/eventsproject"
        registryCredential = 'dockerHub'
        dockerImage = ''
    }
    stages {
        stage("CHECKOUT GIT") {
            steps {
                // Cette étape clone le référentiel Git
                git branch: 'main',  url: 'https://github.com/AdemNajiAvaxia/eventsProject.git'
            }
        }
        stage('MVN CLEAN') {
            steps {
                echo 'Running Maven clean'
                sh 'mvn clean'
            }
        }
        stage('ARTIFACT CONSTRUCTION') {
            steps {
                echo 'Constructing artifact'
                sh 'mvn package -Dmaven.test.skip=true'
            }
        }
        stage('MVN SONARQUBE') {
            steps {
                echo 'Running SonarQube analysis'
                sh 'mvn sonar:sonar -Dsonar.login=admin -Dsonar.password=admin1'
            }
        }
        stage('Tests - JUnit/Mockito') {
            steps {
                sh 'mvn test'
            }
        }
        stage('MVN DEPLOY TO NEXUS') {
            steps {
                sh 'mvn deploy'
            }
        }
        stage('Building image') {
            steps {
                sh 'docker build -t nagui69/eventsproject:1.0.0 .'
            }
        }
        stage('Deploy image') {
            steps {
                sh '''
                    docker login -u nagui69 -p changeme69
                    docker push nagui69/eventsproject:1.0.0
                '''
            }
        }
        stage('Deploy with Docker Compose') {
            steps {
                sh 'docker compose up -d'
            }
        }
    }
}
