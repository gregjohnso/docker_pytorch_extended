# From pytorch compiled from source
FROM rorydm/pytorch_extended:master

# pre-reqs for base notebooks from jupyter-stacks
ENV export DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get -yq dist-upgrade && \
    apt-get install -yq --no-install-recommends \
    wget \
    bzip2 \
    sudo \
    locales \
    tzdata \
    fonts-liberation && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# all OS dependencies for fully functional notebook server from jupyter-stacks
RUN apt-get update && apt-get install -yq --no-install-recommends \
    emacs \
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
    unzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# R pre-requisites from jupyter-stacks
RUN apt-get update && apt-get install -yq --no-install-recommends \
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

# Julia install
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:staticfloat/julianightlies && \
    add-apt-repository -y ppa:staticfloat/julia-deps && \
    apt-get update && \
    apt-get install -y julia && \
    rm -rf /var/lib/apt/lists/*

# Julia packages
RUN julia -e 'Pkg.init()' && \
    julia -e 'Pkg.update()' && \
    julia -e 'Pkg.add("HDF5")' && \
    julia -e 'Pkg.add("Gadfly")' && \
    julia -e 'Pkg.add("RDatasets")' && \
    julia -e 'Pkg.add("IJulia")' && \
    # precompile packages \
    julia -e 'using HDF5' && \
    julia -e 'using Gadfly' && \
    julia -e 'using RDatasets' && \
    julia -e 'using IJulia'
