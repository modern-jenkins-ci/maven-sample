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
        def buildEnv = []

        if(env.http_proxy) {
            def httpProxyUrl = new URL(env.http_proxy)
            def proxyHost = httpProxyUrl.host
            def proxyPort = httpProxyUrl.port

            def javaMavenSettings = "-Dhttp.proxyHost=${proxyHost} -Dhttp.proxyPort=${proxyPort} -Dhttps.proxyHost=${proxyHost} -Dhttps.proxyPort=${proxyPort}"
            buildEnv = ["MAVEN_OPTS=${javaMavenSettings}"]
        }

        withEnv(buildEnv) {
            docker.build(
                "modern-jenkins/maven-sample:${env.BUILD_NUMBER}",
                "--build-arg GIT_COMMIT=${env.GIT_COMMIT} ."
            )
        }
    }
}