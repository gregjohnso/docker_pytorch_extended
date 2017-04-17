from pytorch-cudnnv6

RUN pip install jupyter
RUN  painstall numpy scipy natsort pillow -y
RUN pip install matplotlib

# Set up notebook config
COPY jupyter_notebook_config.py /root/.jupyter/

# Jupyter has issues with being run directly: https://github.com/ipython/ipython/issues/7062

# Expose Ports for Ipython (8888)
EXPOSE 9999

WORKDIR "/root"

RUN apt-get update
RUN apt-get install vim -y
