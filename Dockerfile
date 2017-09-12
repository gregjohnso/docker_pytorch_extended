FROM pytorch/pytorch

RUN pip --no-cache-dir install \
    jupyter\
    natsort\
    pillow \
    matplotlib \
    torchvision \
    scikit-learn \
    scikit-image \
    pandas \
    h5py \
    tqdm \
    autopep8 

## Configure Jupiter notebook extensions

# Set up notebook config
RUN jupyter nbextension enable --py widgetsnbextension
  COPY jupyter_notebook_config.py /root/.jupyter/

# Set up notebook extensions
RUN jupyter contrib nbextension install --user
RUN jupyter nbextensions_configurator enable --user
# Install vim bindings
  RUN jupyter nbextension install https://github.com/lambdalisue/jupyter-vim-binding/archive/master.tar.gz --system
  RUN jupyter nbextension enable jupyter-vim-binding-master/vim_binding
  RUN mkdir -p /root/.jupyter/custom
  COPY custom.js /root/.jupyter/custom


# Expose Ports for Ipython (9999)
EXPOSE 9999

# Move to home dir for root
WORKDIR "/root"

RUN apt-get update
RUN apt-get install -y vim
RUN apt-get install -y python-qt4

# Add aicsimage repo
RUN git clone https://github.com/AllenCellModeling/aicsimage.git /opt/aicsimage && \
    cd /opt/aicsimage && \
    pip install -r requirements.txt && \
    pip install -e .

