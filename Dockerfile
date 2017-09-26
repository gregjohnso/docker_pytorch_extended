# From pytorch compiled from source
FROM rorydm/pytorch:master

# pytoch image comes with:
#   ubuntu: build-essential cmake git curl vim ca-certificates libjpeg-dev libpng-dev
#   python: numpy pyyaml scipy ipython mkl (in the pytorch-py35 conda environment)

RUN apt-get update && apt-get -yq dist-upgrade && \
    apt-get install -yq --no-install-recommends \
    wget \
    bzip2 \
    ca-certificates \
    sudo \
    locales \
    fonts-liberation && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install all OS dependencies for fully functional notebook server
RUN apt-get update && apt-get install -yq --no-install-recommends \
    build-essential \
    emacs \
    git \
    inkscape \
    jed \
    libsm6 \
    libxext-dev \
    libxrender1 \
    lmodern \
    pandoc \
    python-dev \
    texlive-fonts-extra \
    texlive-fonts-recommended \
    texlive-generic-recommended \
    texlive-latex-base \
    texlive-latex-extra \
    texlive-xetex \
    vim \
    unzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# R pre-requisites
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    fonts-dejavu \
    gfortran \
    gcc && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# R packages
RUN conda install -y --name pytorch-py35 -c r \
    r-base \
    r-irkernel \
    r-devtools \
    r-tidyverse \
    r-rmarkdown \
    r-glmnet \
    r-caret \
    r-gplots \
    r-rcolorbrewer && \
    conda clean -tipsy

# install more python stuff
RUN conda install -y --name pytorch-py35 \
    jupyter \
    natsort \
    pillow \
    matplotlib \
    scikit-learn \
    scikit-image \
    pandas \
    h5py \
    tqdm && \
    conda clean -tipsy

# including packages not in the main repo
RUN pip install \
    yapf \
    fire


# Set up notebook config
COPY jupyter_notebook_config.py /root/.jupyter/

# Enable JS widgets
RUN jupyter nbextension enable --py --sys-prefix widgetsnbextension

# Install contributed notebook extensions
RUN pip install https://github.com/ipython-contrib/jupyter_contrib_nbextensions/tarball/master && \
    jupyter contrib nbextension install --system && \
    jupyter nbextension enable collapsible_headings/main && \
    jupyter nbextension enable spellchecker/main

# Install vim bindings
RUN jupyter nbextension install https://github.com/lambdalisue/jupyter-vim-binding/archive/master.tar.gz --system && \
    jupyter nbextension enable jupyter-vim-binding-master/vim_binding && \
    mkdir -p /root/.jupyter/custom
COPY custom.js /root/.jupyter/custom


# Expose Ports for Ipython (9999)
EXPOSE 9999

# Move to home dir for root
WORKDIR "/root"

# Add aicsimage repo
RUN git clone https://github.com/AllenCellModeling/aicsimage.git /opt/aicsimage && \
    cd /opt/aicsimage && \
    pip install -r requirements.txt && \
    pip install -e .

# data augmentation
RUN pip install nibabel && \
    git clone https://github.com/ncullen93/torchsample.git && \
    cd torchsample && \
    python setup.py install

# Install Julia.
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:staticfloat/julianightlies && \
    add-apt-repository -y ppa:staticfloat/julia-deps && \
    apt-get update && \
    apt-get install -y julia && \
    rm -rf /var/lib/apt/lists/*

RUN julia -e 'Pkg.init()' && \
    julia -e 'Pkg.update()' && \
    julia -e 'Pkg.add("HDF5")' && \
    julia -e 'Pkg.add("Gadfly")' && \
    julia -e 'Pkg.add("RDatasets")' && \
    julia -e 'Pkg.add("IJulia")' && \
    # Precompile Julia packages \
    julia -e 'using HDF5' && \
    julia -e 'using Gadfly' && \
    julia -e 'using RDatasets' && \
    julia -e 'using IJulia'
