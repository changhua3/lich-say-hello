pipeline {
  agent {
    node {
      label 'maven'
    }

  }
  stages {
    stage('code clone') {
      agent none
      steps {
        container('maven') {
          git(url: 'https://github.com/changhua3/lich-say-hello.git', credentialsId: 'github-id', branch: 'main', changelog: true, poll: false)
          sh 'ls -lah'
        }

      }
    }

    stage('project build') {
      agent none
      steps {
        container('maven') {
          sh 'ls -lah'
          sh 'mvn clean package -Dmaven.test.skip=true'
          sh 'ls -lah'
          sh 'ls -lah target'
        }

      }
    }

    stage('build image') {
      agent none
      steps {
        container('maven') {
          sh 'docker build -t lich-say-hello:latest -f Dockerfile .'
          sh 'docker images | grep lich-say-hello'
        }

      }
    }

    stage('push image') {
      agent none
      steps {
        container('maven') {
          withCredentials([usernamePassword(credentialsId : 'docker-id' ,usernameVariable : 'DOCKER_USER_VAR' ,passwordVariable : 'DOCKER_PASSWORD_VAR' ,)]) {
            sh 'echo "$DOCKER_PASSWORD_VAR" | docker login $REGISTRY -u "$DOCKER_USER_VAR" --password-stdin'
            sh 'docker  tag lich-say-hello:latest $REGISTRY/$DOCKERHUB_NAMESPACE/lich-say-hello:$BUILD_NUMBER'
            sh 'docker push $REGISTRY/$DOCKERHUB_NAMESPACE/lich-say-hello:$BUILD_NUMBER'
            sh 'printenv'
          }

        }

      }
    }

    stage('deploy to prod') {
      agent none
      steps {
<<<<<<< HEAD
        container('maven') {
          withCredentials([
                                      kubeconfigFile(
                                        credentialsId: env.KUBECONFIG_CREDENTIAL_ID,
                                        variable: 'KUBECONFIG')
                                        ]) {
                sh 'printenv'
                sh 'envsubst < deploy/deploy.yaml | kubectl apply -f -'
              }

            }

          }
        }

=======
        kubernetesDeploy(configs: 'deploy/deploy.yaml', enableConfigSubstitution: true, kubeconfigId: "$KUBECONFIG_CREDENTIAL_ID")
>>>>>>> 0e80281cce4341025b90882cd1e011d7fa92b29e
      }
    }
  }
      environment {
        DOCKER_CREDENTIAL_ID = 'dockerhub-id'
        GITHUB_CREDENTIAL_ID = 'github-id'
        KUBECONFIG_CREDENTIAL_ID = 'kubeconfig-id'
        REGISTRY = 'docker.io'
        DOCKERHUB_NAMESPACE = 'changhua3'
        GITHUB_ACCOUNT = 'kubesphere'
        APP_NAME = 'taobao'
      }
    }
