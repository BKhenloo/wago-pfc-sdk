FROM docker.io/ubuntu:latest
MAINTAINER "Briezh Khenloo"

##
# Create User
RUN useradd -m -s /bin/bash -g root -u 1000 wago

##
# Install GIT to pull content: PFC-Firmware-SDK, Cross-Toolchain, ptxdist
RUN apt-get update && apt-get install -y apt-utils git git-lfs wget \
 &&	git clone https://github.com/wago/pfc-firmware-sdk.git /home/wago/ptxproj \
 &&	git clone https://github.com/wago/gcc-toolchain-2019.12-precompiled.git /opt/gcc-Toolchain-2019.12 \
 &&	chown wago:root /home/wago -R
# Get build utilities and build ptxdist env
RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y tzdata \
		libncurses5-dev gawk flex bison texinfo python-dev g++ dialog lzop autoconf libtool xmlstarlet xsltproc doxygen autopoint \
		make gettext \
 &&	git clone https://github.com/wago/ptxdist.git /tmp/ptxdist && cd /tmp/ptxdist && ./configure && make && make install && cd ~ && rm -rf /tmp/ptxdist

# Make Clean
#RUN DEBIAN_FRONTEND="noninteractive" apt-get purge -y git git-lfs \
# && DEBIAN_FRONTEND="noninteractive" apt-get autoclean \
# && DEBIAN_FRONTEND="noninteractive" apt-get clean \
# && DEBIAN_FRONTEND="noninteractive" apt-get autoremove \
# &&	rm -rf /var/lib/apt/lists/*

# Set content
VOLUME /home/wago
USER wago
WORKDIR /home/wago

##
# Configure the "project environment"
#	1. Select "software config" we want to build
#	2. Select "hardware platform" to dial with
#	3. Select "toolchain" to use
# ToDo
#	- Enter the main menu dialog once
#		ptxdist menu
#	- Open the menuconfig dialog once
#		ptxdist menuconfig
RUN cd /home/wago/ptxproj \
 &&	ptxdist select configs/wago-pfcXXX/ptxconfig_generic \
 &&	ptxdist platform configs/wago-pfcXXX/platformconfig \
 &&	ptxdist toolchain /opt/gcc-Toolchain-2019.12/arm-linux-gnueabihf/bin/

##
# Get SRC
RUN wget https://github.com/nlohmann/json/archive/v3.7.0.tar.gz /tmp/v3.7.0.tar.gz \
 &&	mkdir -p /home/wago/ptxproj/src && tar xzf /tmp/v3.7.0.tar.gz -C /home/wago/ptxproj/src \ 
 && rm -rf *gz
