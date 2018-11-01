node('docker') {
    stage('Get Latest Code') {
        cleanWs()
        checkout scm
    }

    stage('Maven Build') {
        docker.image('maven:3.3-jdk-8').inside {
            sh 'mvn clean package'
            sh 'ls -al $WORKSPACE/target'
        }
    }

    stage('Build Docker Image') {
        docker.build(
            "modern-jenkins/maven-sample:${env.BUILD_NUMBER}",
            "--build-arg GIT_COMMIT=${env.GIT_COMMIT} ."
        )
    }
}