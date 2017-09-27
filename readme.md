# PyTorch + Jupyter + GPUs

Creates a docker image for running PyTorch on NVIDIA GPUs with Jupyter notebook support

## Structure

- There's a "regular" dockerfile in the `pytorch_extended` subdirectory -- pretty much what we've been using for a while.  It also has vim bindings and all that, but disabled by default.  This is sort of our "base" image.

- There's a "fancy" version in the `pytorch_datascience` subdirectory, which also has R and Julia installed and set up to work with Jupyter.  This version is built off of the `pytorch_extended` one.

- Build either from the main directory by using `bash build_dockerfile.sh <subdir_name>`.

- Run either from the main directory by using `bash run_docker_image.sh <subdir_name> <port>`, where `<port>` is the port your'e forwarding out of the docker container, e.g. 9699.


## Detailed Installlation Instructions
- On an Ubuntu system (e.g. aws) install current nvidia drivers:
  - `sudo add-apt-repository ppa:graphics-drivers/ppa`
  - `sudo apt-get update && sudo apt-get install nvidia-378`

- Install nvida docker (and docker): https://github.com/NVIDIA/nvidia-docker (use whatever is current, not necessarily `v1.0.1`)
  - `wget -P /tmp https://github.com/NVIDIA/nvidia-docker/releases/download/v1.0.1/nvidia-docker_1.0.1-1_amd64.deb`
  - `sudo dpkg -i /tmp/nvidia-docker*.deb && rm /tmp/nvidia-docker*.deb`

- Install pytorch on docker: https://github.com/pytorch/pytorch (at the time of writing the dockerfile is named pytorch-cudnnv6)
  - `git clone https://github.com/pytorch/pytorch.git`
  - `cd pytorch && docker build -t ${USER}/pytorch:master .`

- Clone this repo next to the pytorch one and run the build script
  - `bash build_dockerfile.sh pytorch_extended` to first build the minimally extended version
  - `bash build_dockerfile.sh pytorch_datascience` to next build the version with R and Julia

- To run and start a jupyter server (maybe start a screen session first), from this directory:
  - `bash run_docker_image.sh <subdir_name> <port>`

- To enter the running docker container:
  - `docker exec -it <container_name> bash`
