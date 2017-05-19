# this file's name could change based on what the pytorch repo uses in the future
from pytorch-cudnnv6

# install jupyter and some other utils
#RUN /opt/conda/bin/conda install --name pytorch-py35 jupyter natsort pillow matplotlib -y
#RUN /opt/conda/bin/conda install --name pytorch-py35 torchvision -c soumith -y

RUN pip install jupyter
RUN pip install natsort
RUN pip install pillow
RUN pip install matplotlib
RUN pip install torchvision
RUN pip install scikit-learn
RUN pip install pandas
RUN pip install h5py

# Set up notebook config
COPY jupyter_notebook_config.py /root/.jupyter/

# Expose Ports for Ipython (9999)
EXPOSE 9999

WORKDIR "/root"

RUN apt-get update
RUN apt-get install -y vim
RUN apt-get install -y python-qt4
