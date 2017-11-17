#!/usr/bin/env bash

TAG=${1%/}
PORT=${2}

nvidia-docker run --rm -ti --ipc=host \
    -e "PASSWORD=jupyter1" \
    -p ${PORT}:9999 \
    -v /allen/aics/modeling/${USER}/projects:/root/projects \
    -v /allen/aics:/root/aics \
    rorydm/pytorch_extras:${TAG} \
    bash -c "jupyter notebook --allow-root --NotebookApp.iopub_data_rate_limit=10000000000"

