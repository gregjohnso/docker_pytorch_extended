Creates a docker image based on jupyter notebook, and installs a handful of python utils 

Note: One may need to change the docker image in the Dockerfile based on what was installed in step 1.


Steps
1) Install pytorch on docker from here:
https://github.com/pytorch/pytorch  
At the time of writing the dockerfile is named pytorch-cudnnv6

2) Run build_pytorch_extended.sh  
$ bash runme.sh

3) Run interactively  
$ bash run_pytorch_extended.sh


