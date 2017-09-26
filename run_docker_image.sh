#!/usr/bin/env bash

IMG_TYPE=$1
PORT=$2
THIS_DIR=$(pwd -P)
TAG=$(git symbolic-ref --short -q HEAD)

nvidia-docker run --rm -ti --ipc=host \
    -e "PASSWORD=jupyter1" \
    -p ${PORT}:9999 \
    -v /allen/aics/modeling/${USER}/projects:/root/projects \
    -v /allen/aics/modeling/data:/root/data \
    -v /allen/aics/modeling/gregj/results:/root/results \
    ${USER}/${IMG_TYPE}:${TAG} \
    bash -c "jupyter notebook --allow-root --NotebookApp.iopub_data_rate_limit=10000000000"

