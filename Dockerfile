# Get basis image
FROM ubuntu:16.04

# Install packages
RUN apt-get update -y
RUN apt-get -y install vim\
        git\
        sed\
        make\
        binutils\
        gcc\
        g++\
        patch\
        gzip\
        bzip2\
        perl\
        tar\
        cpio\
        python\
        unzip\
        rsync\
        wget\
        libncurses-dev\
        bc

# Setup home environment
RUN useradd -ms /bin/bash bone
USER bone
WORKDIR /home/bone/bbb-hal
