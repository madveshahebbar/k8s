pipeline {
environment {
    registry = "madvesha/k8"
    registryCredential = "DOCKER"
    dockerImage = ''
}
agent { label 'k8s' }
stages {
    stage('Cloning Git') {
      steps {
	      checkout changelog: false, poll: false, scm: [$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/madveshahebbar/k8s.git']]]
		  }
		}
	 stage('Docker build and Push'){
	  steps {
	     script {
	      dockerImage = docker.build registry + ":$BUILD_NUMBER"
          docker.withRegistry( '', registryCredential ) {
          dockerImage.push()
           }
		  }
        }
      }
	 stage('Deploy in K8s'){
	  steps {
	     script {
	       def build_id = "$BUILD_NUMBER"
	       sh ("sed -i \'s/test/$build_id/g\' pods.yaml")
	       sh ("kubectl create -f .")
	       sh ("docker rmi $registry:$BUILD_NUMBER")
	     }
}
}
}
}
