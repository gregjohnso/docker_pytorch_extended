from pytorch-cudnnv6

RUN /opt/conda/bin/conda install -y jupyter natsort pillow matplotlib

# Set up notebook config
COPY jupyter_notebook_config.py /root/.jupyter/

# Expose Ports for Ipython (9999)
EXPOSE 9999

WORKDIR "/root"

RUN apt-get update
RUN apt-get install -y vim
