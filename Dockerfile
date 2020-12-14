FROM docker.io/ubuntu:latest
MAINTAINER "Briezh Khenloo"

##
# Create User
RUN useradd -m -s /bin/bash -g root -u 1000 wago

##
# Install GIT to pull content: PFC-Firmware-SDK, Cross-Toolchain, ptxdist
RUN apt-get update && apt-get install -y git git-lfs \
 &&	git clone https://github.com/wago/pfc-firmware-sdk.git /home/wago/ptxproj \
 &&	git clone https://github.com/wago/gcc-toolchain-2019.12-precompiled.git /opt/gcc-Toolchain-2019.12 \
 &&	chown wago:root /home/wago -R
# Get build utilities and build ptxdist env
RUN DEBIAN_FRONTEND="noninteractive" && apt-get install -y tzdata \
 &&	apt-get install -y libncurses5-dev gawk flex bison texinfo python-dev g++ dialog lzop autoconf libtool xmlstarlet xsltproc doxygen autopoint \
 &&	apt-get install -y wget make gettext \
 &&	git clone https://github.com/wago/ptxdist.git /tmp/ptxdist && cd /tmp/ptxdist && ./configure && make && make install && cd ~ && rm -rf /tmp/ptxdist

# Make Clean
RUN rm -rf /var/lib/apt/lists/*

# Set content
VOLUME /home/wago
USER wago
WORKDIR /home/wago
