pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh '''#!/bin/bash
                    workspace=$WORKSPACE
                    echo "Running in: \${workspace}"
                    realPath="/volume1/docker/configs/jenkins\${workspace:17}"
                    echo "Real path: \${realPath}"
                    
                    inputFiles=""
                    outputFile="docker-compose.yml"
                    #echo "Generating .env file from Jenkins secrets"
                    #cat $dockerEnv > .env

                    echo "Copying .env file"
                    cp /volume1/docker/.env .env
                    cat test.txt | envsubst > test.txt
                
                    echo "Generating \${outputFile}"
                    
                    #for file in `ls`; do
                    #    if [[ \$file =~ docker-compose\\.([a-zA-Z0-9]*)\\.y(a|)ml ]]; then
                    #        inputFiles+=" \$file"
                    #    fi
                    #done
                    #if [[ \$inputFiles == "" ]]; then
                    #    echo "No input files found. Exiting."
                    #    exit
                    #fi
                    #echo "Merging:\${inputFiles}"
                    #docker run --rm -i -v \${realPath}:/workdir mikefarah/yq yq merge \$inputFiles > "\${outputFile}"
                    #echo "Merge complete"
                '''
            }
        }
        stage('Deploy') {
            steps {
                sh './deploy.sh'
            }
        }
    }
}