# this file's name could change based on what the pytorch repo uses in the future
from pytorch-cudnnv6

RUN pip install jupyter
RUN pip install natsort
RUN pip install pillow
RUN pip install matplotlib
RUN pip install torchvision
RUN pip install scikit-learn
RUN pip install pandas
RUN pip install h5py
RUN pip install tqdm

# Set up notebook config
COPY jupyter_notebook_config.py /root/.jupyter/

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

