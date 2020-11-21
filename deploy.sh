#!/bin/bash

echo "Deploy started"
cd ./deploy

for file in `ls`; do
    if [[ $file =~ ^([0-9]*)-(.*)\.sh$ ]]; then
        echo "Executing "$file
        sh $file
    else
        echo "Skipping "$file
    fi
done