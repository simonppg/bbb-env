FROM ubuntu:16.04
RUN apt-get update
RUN adduser bone
ENV HOME /home/bone
COPY . /home/bone/bbb-hal
WORKDIR /home/bone/bbb-hal
CMD su bone
