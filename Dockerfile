FROM ubuntu:20.04

MAINTAINER jmonlong@ucsc.edu

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    wget \
    curl \
    gcc \ 
    samtools \
    tzdata \
    make \
    cmake \
    build-essential \
    bzip2 \
    git \
    sudo \
    pkg-config \
    python3 \
    python3-pip \
    python3-setuptools \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

ENV TZ=America/Los_Angeles

## install python3 requirements
RUN pip3 install --upgrade pip

RUN pip3 install --no-cache-dir matplotlib

WORKDIR /build

## minimap2
RUN wget https://github.com/lh3/minimap2/releases/download/v2.24/minimap2-2.24_x64-linux.tar.bz2 && \
    tar -jxvf minimap2-2.24_x64-linux.tar.bz2 && \
    rm minimap2-2.24_x64-linux.tar.bz2

ENV PATH=/build/minimap2-2.24_x64-linux/:$PATH

## Liger2LiGer
RUN git clone https://github.com/rlorigro/Liger2LiGer.git && \
    cd Liger2LiGer && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make

WORKDIR /home
