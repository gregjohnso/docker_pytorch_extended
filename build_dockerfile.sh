#!/usr/bin/env bash

# tag the image with the current git branch name
TAG=${1%/}

# and build
docker build -t rorydm/pytorch_extras:${TAG} -f ${TAG}/Dockerfile .

