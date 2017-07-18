# this file's name could change based on what the pytorch repo uses in the future
from pytorch

RUN pip install jupyter
RUN pip install natsort
RUN pip install pillow
RUN pip install matplotlib
RUN pip install torchvision
RUN pip install scikit-learn
RUN pip install pandas
RUN pip install h5py
RUN pip install tqdm
RUN pip install autopep8
RUN pip install jupyter_nbextensions_configurator
RUN pip install jupyter_contrib_nbextensions

# Set up notebook config
COPY jupyter_notebook_config.py /root/.jupyter/
RUN jupyter nbextension enable --py widgetsnbextension

# Set up notebook extensions
RUN jupyter contrib nbextension install --user
RUN jupyter nbextensions_configurator enable --user

# Get vim bindings set up
RUN git clone https://github.com/lambdalisue/jupyter-vim-binding $(jupyter --data-dir)/nbextensions/vim_binding
RUN mkdir -p /root/.jupyter/custom
COPY custom.js /root/.jupyter/custom

# Expose Ports for Ipython (9999)
EXPOSE 9999

WORKDIR "/root"

RUN apt-get update
RUN apt-get install -y vim
RUN apt-get install -y python-qt4

# add aicsimage repo
RUN git clone https://github.com/AllenCellModeling/aicsimage.git /opt/aicsimage && \
    cd /opt/aicsimage && \
    pip install -r requirements.txt && \
    pip install -e .

