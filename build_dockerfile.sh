#!/usr/bin/env bash

IMG_TYPE=${1}

# tag the image with the current git branch name
TAG=$(git symbolic-ref --short -q HEAD)

cd ${IMG_TYPE}

# and put in a repository named after the current user
docker build -t ${USER}/${IMG_TYPE}:${TAG} -f Dockerfile .

