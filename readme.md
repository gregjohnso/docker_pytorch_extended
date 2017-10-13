# PyTorch + Jupyter + GPUs

Creates a docker image for running PyTorch on NVIDIA GPUs with Jupyter notebook support

## Structure

- There's a "regular" dockerfile in the `jupyter` subdirectory -- pretty much what we've been using for a while.  It also has vim bindings and all that, but disabled by default.  This is sort of our "base" image.

- There's a "fancy" versionis in the `jupyter_R` and `jupyter_R_julia` subdirectories, which also have R and Julia installed and set up to work with Jupyter.  The `jupyter_R` version is built off of the `jupyter` image, and `jupyter_R_julia` is built off of `jupyter_R`.

- If you just want to run things and not build them yourself, use `docker pull rorydm/pytoch_extras:<tag>` where `<tag>` is (say) `jupyter_R_julia` to pull the prebuilt images from docker hub.

- To build any of the images yourself, from the main directory use `bash build_dockerfile.sh <subdir_name>`.

- Run any of from the main directory by using `bash run_docker_image.sh <subdir_name> <port>`, where `<port>` is the port you're forwarding out of the docker container, e.g. 9699.


## Detailed Installlation Instructions
- On an Ubuntu system (e.g. aws) install current nvidia drivers:
  - `sudo add-apt-repository ppa:graphics-drivers/ppa`
  - `sudo apt-get update && sudo apt-get install nvidia-378`

- Install nvida docker (and docker): https://github.com/NVIDIA/nvidia-docker (use whatever is current, not necessarily `v1.0.1`)
  - `wget -P /tmp https://github.com/NVIDIA/nvidia-docker/releases/download/v1.0.1/nvidia-docker_1.0.1-1_amd64.deb`
  - `sudo dpkg -i /tmp/nvidia-docker*.deb && rm /tmp/nvidia-docker*.deb`

- Install pytorch on docker: https://github.com/pytorch/pytorch (at the time of writing the dockerfile is named pytorch-cudnnv6)
  - `git clone https://github.com/pytorch/pytorch.git`
  - `cd pytorch && docker build -t rorydm/pytorch:master .`

- Clone this repo next to the pytorch one and run the build script
  - `bash build_dockerfile.sh jupyter` to first build the minimally extended version
  - `bash build_dockerfile.sh jupyter_R` to next build the version with R
  - `bash build_dockerfile.sh jupyter_R_julia` to next build the version with R and Julia

- To run and start a jupyter server (maybe start a screen session first), from this directory:
  - `bash run_docker_image.sh <subdir_name> <port>`

- To enter the running docker container:
  - `docker exec -it <container_name> bash`
