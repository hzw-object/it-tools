pipeline {
    agent any
    environment {
        NAME = 'hzw-it-tools'
        PROFILE = 'dev'
        APP = 'hzw-it-tools'
        APP_PORT = 8002
    }
    tools {
        nodejs 'node16' // 指定 Node.js 工具的名称或安装目录
    }
    stages {
        stage('下载代码') {
            steps {
                echo '****************************** download code start... ******************************'
                git branch: 'main', credentialsId: '17535292991', url: 'git@github.com:hzw-object/it-tools.git'
            }
        }
        stage('构建Docker镜像') {
            steps {
                echo '****************************** delete container and image... ******************************'
                sh 'docker ps -a|grep $NAME|awk \'{print $1}\'|xargs -i docker stop {}|xargs -i docker rm {}'
                sh 'docker images|grep $NAME|grep dev|awk \'{print $3}\'|xargs -i docker rmi {}'

                echo '****************************** build image... ******************************'
                sh 'docker build --build-arg PROFILE=dev -t $APP .'
            }
        }

        stage('运行容器') {
            steps {
                echo '****************************** run start... ******************************'
                sh 'docker run -d -p $APP_PORT:80 --restart=always --name $NAME $APP'
            }
        }
    }
}

