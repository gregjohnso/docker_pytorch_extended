# this file's name could change based on what the pytorch repo uses in the future
from pytorch-cudnnv6

# install jupyter and some other utils
RUN /opt/conda/bin/conda install --name pytorch-py35 jupyter natsort pillow matplotlib -y --quiet

# Set up notebook config
COPY jupyter_notebook_config.py /root/.jupyter/

# Expose Ports for Ipython (9999)
EXPOSE 9999

WORKDIR "/root"

RUN apt-get update
RUN apt-get install -y vim
