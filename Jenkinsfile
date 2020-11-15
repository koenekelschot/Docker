pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                // 'docker-env-file' contains the .env file used for docker-compose
                withCredentials([file(credentialsId: 'docker-env-file', variable: 'dockerEnv')]) {
                    sh '''#!/bin/bash
                        workspace=$WORKSPACE
                        echo "Running in: \${workspace}"
                        realPath="/volume1/docker/configs/jenkins\${workspace:17}"
                        echo "Real path: \${realPath}"
                        
                        inputFiles=""
                        outputFile="docker-compose.yml"

                        echo "Generating .env file from Jenkins secrets"
                        cat $dockerEnv > .env
                    
                        echo "Generating \${outputFile}"
                        
                        for x in `ls`; do
                            if [[ \$x =~ docker-compose\\.([a-zA-Z0-9]*)\\.y(a|)ml ]]; then
                                inputFiles+=" \$x"
                            fi
                        done

                        if [[ \$inputFiles == "" ]]; then
                            echo "No input files found. Exiting."
                            exit
                        fi

                        echo "Merging:\${inputFiles}"
                        docker run --rm -i -v \${realPath}:/workdir mikefarah/yq yq merge \$inputFiles > "\${outputFile}"
                        echo "Merge complete"
                    '''
                }
            }
        }
        // stage('Deploy') {
        //     steps {
        //         // 
        //     }
        // }
    }
}