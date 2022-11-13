#!/bin/bash

configPath="$1"

cp "${configPath}" /etc/nginx/conf.d/default.conf
result=$(nginx -c /etc/nginx/nginx.conf -t 2>&1)
printf "%s\n" "$result"

# Look for the word successful and count the lines that have it
successful=$(echo "$result" | grep -c successful)

test "$successful" -eq 0 && exit 1 || exit 0
