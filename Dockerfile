# Get basis image
FROM ubuntu:16.04

# Install packages
RUN apt-get update -y
RUN apt-get -y install vim

# Setup home environment
RUN adduser bone

WORKDIR /home/bone/bbb-hal
ENV HOME /home/bone
COPY . /home/bone/bbb-hal

RUN chown -R bone: /home/bone
USER bone
