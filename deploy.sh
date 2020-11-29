#!/bin/bash

find $PWD -mindepth 2 -name "deploy.sh" -exec sh {} \;
/usr/local/bin/docker-compose up -d --remove-orphans