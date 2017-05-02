#!/bin/bash
docker build -t my_docker/lambda-r .
docker run -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY -e S3_URL=$S3_URL -it --rm my_docker/lambda-r
