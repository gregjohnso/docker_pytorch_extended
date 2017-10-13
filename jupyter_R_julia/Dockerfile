# From pytorch compiled from source
FROM rorydm/pytorch_extras:jupyter_R

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
