#!/bin/bash

find "./projects" -mindepth 1 -name "deploy.sh" -exec sh {} \;
/usr/local/bin/docker-compose up -d --remove-orphans