#!/bin/sh

# we gonna follow these steps in ci/cd pipeline
tag=$1

npm run build
aws s3 sync dist/img s3://assets.everwell/img  --acl public-read
aws s3 sync dist/css s3://assets.everwell/css  --acl public-read
aws s3 sync dist/js s3://assets.everwell/js  --acl public-read
docker build -t vaibhavmehta/pwa-weather-app:$tag .
docker push vaibhavmehta/pwa-weather-app:$tag


curl -v -X GET http://localhost:8080/job/PWA-weather-frontend-production-trigger/build
