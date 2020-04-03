FROM ubuntu:18.04

RUN apt-get update && \
    apt-get install -y \
    build-essential \
    libssl-dev \
    uuid-dev \
    libgpgme11-dev \
    squashfs-tools \
    libseccomp-dev \
    wget \
    pkg-config \
    git

# install Go
ENV GO_VERSION=1.12
ENV OS=linux
ENV ARCH=amd64
RUN wget https://dl.google.com/go/go$GO_VERSION.$OS-$ARCH.tar.gz && \
    tar -C /usr/local -xzvf go$GO_VERSION.$OS-$ARCH.tar.gz && \
    rm go$GO_VERSION.$OS-$ARCH.tar.gz

# install Singularity
ENV PATH=/usr/local/go/bin:$PATH
ENV SINGULARITY_VERSION=3.3.0
RUN wget https://github.com/sylabs/singularity/releases/download/v${SINGULARITY_VERSION}/singularity-${SINGULARITY_VERSION}.tar.gz && \
    tar -xzf singularity-${SINGULARITY_VERSION}.tar.gz && \
    cd singularity && \
    ./mconfig && \
    make -C builddir && \
    make -C builddir install
