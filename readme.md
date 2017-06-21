# PyTorch + Jupyter on GPUs (on aws)

Creates a docker image for running PyTorch on NVIDIA GPUs with Jupyter notebook support, and installs a handful of Python utils.

Note: One may need to change the docker image in the Dockerfile from `pytorch-cudnnv6` to something else based on what the PyTorch docker build is named.


This branch is different from master in that it installs the package http://jupyter-contrib-nbextensions.readthedocs.io/en/latest/. This provides access to some nice add-ones, including:
- Table of Contents: Automatically adds table of contents in the sidebar of a Jupyter notebook.
- Autopep8: Automatic code cleanup for pep8 compliance.
- table_beautifier: Sorting of Pandas DataFrames printed as tables, etc.
- VIM binding: vim bindings within Jupyter notebook.

Some of the extensions seem not to work (TODO: figure out why), but a few useful ones do.


## Installlation Instructions
- On an Ubuntu system (e.g. aws) install current nvidia drivers:
  - `sudo add-apt-repository ppa:graphics-drivers/ppa`
  - `sudo apt-get update && sudo apt-get install nvidia-378`

- Install nvida docker (and docker): https://github.com/NVIDIA/nvidia-docker
  - `wget -P /tmp https://github.com/NVIDIA/nvidia-docker/releases/download/v1.0.1/nvidia-docker_1.0.1-1_amd64.deb`
  - `sudo dpkg -i /tmp/nvidia-docker*.deb && rm /tmp/nvidia-docker*.deb`

- Install pytorch on docker: https://github.com/pytorch/pytorch (at the time of writing the dockerfile is named pytorch-cudnnv6)
  - `git clone https://github.com/pytorch/pytorch.git`
  - `cd pytorch && docker build -t pytorch-cudnnv6 .`

- Clone this repo next to the pytorch one and run the build script
  - `build_pytorch_extended.sh`

- To run interactively (maybe start a screen session first):
  - `bash run_pytorch_extended.sh`


  - To use jupyter: once in the docker container
    - `jupyter notebook --allow-root`
    - and then the notebook should be available on port 9999 on http
