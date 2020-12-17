FROM docker.io/ubuntu:latest
MAINTAINER "Briezh Khenloo"

##
# Install nessesary content by APT
RUN apt-get update \
 && DEBIAN_FRONTEND="noninteractive" apt-get install -y tzdata \
		libncurses5-dev gawk flex bison texinfo python-dev g++ dialog lzop autoconf libtool xmlstarlet xsltproc doxygen autopoint \
		make gettext wget \
		apt-utils git git-lfs
		

# Set timezone
ENV TZ=Europe/Berlin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone


##
# Get Cross-Compiler-Toolchain
RUN git clone https://github.com/wago/gcc-toolchain-2019.12-precompiled.git --depth 1 /opt/gcc-toolchain-2019.12

##
# Create User
RUN useradd -m -s /bin/bash -g root -u 1000 wago


##
# Create ptxdist environment
USER wago
ADD ptxdist /home/wago/
RUN cd /home/wago/ptxdist && ./configure && make
USER root
RUN cd /home/wago/ptxdist && make install && cd .. && rm -rf /home/wago/ptxdist

##
# Make Clean
RUN rm -rf /var/lib/apt/lists/*
 

##
# ADD INIT script
ADD container-setup.sh /usr/bin/
RUN chmod 755 /usr/bin/container-setup.sh

##
# Set environment, volume(s), ...
ENV 'ptxproj=https://github.com/wago/pfc-firmware-sdk.git --depth 1'
ENV 'ptxsrc=https://github.com/nlohmann/json.git --branch v3.7.0 --depth 1'

VOLUME /home/wago/ptxproj

USER wago

WORKDIR /home/wago

ENTRYPOINT ["/usr/bin/container-setup.sh"]
CMD ["startup"]


