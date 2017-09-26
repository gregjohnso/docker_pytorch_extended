#!/usr/bin/env bash

PORT=$1
THIS_DIR=$(pwd -P)

nvidia-docker run -it \
    -e "PASSWORD=jupyter1" \
    -p ${PORT}:9999 \
    -v ${THIS_DIR}:/root/projects \
    -v /allen/aics/modeling/data:/root/data \
    -v /allen/aics/modeling/gregj/results:/root/results \
    rorydm/pytorch_extended:pytorch0.2_conda \
    bash -c "jupyter notebook --allow-root --NotebookApp.iopub_data_rate_limit=10000000000"

# nvidia-docker run -it -e "PASSWORD=jupyter1" -p 9999:9999 -v /home/ubuntu/docker_pytorch_extended:/root/notebooks gregj/pytorch_extended bash
