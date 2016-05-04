FROM ubuntu:14.04
MAINTAINER Jan Keromnes "janx@linux.com"

# Install Servo build dependencies.
# Packages after "python-virtualenv" are from https://github.com/servo/servo/blob/master/README.md#prerequisites
RUN apt-get update -q && apt-get install -qy git mesa-utils mesa-utils-extra python-virtualenv curl freeglut3-dev autoconf libfreetype6-dev libgl1-mesa-dri libglib2.0-dev xorg-dev gperf g++ build-essential cmake python-dev python-pip libssl-dev libbz2-dev libosmesa6-dev libxmu6 libxmu-dev libglu1-mesa-dev libgles2-mesa-dev libegl1-mesa-dev
ENV SHELL /bin/bash

# Don't be root.
RUN useradd -m user
USER user
ENV HOME /home/user
WORKDIR /home/user

# Download Servo's source code.
RUN git clone https://github.com/servo/servo
WORKDIR servo

# Build Servo.
RUN ./mach build -d