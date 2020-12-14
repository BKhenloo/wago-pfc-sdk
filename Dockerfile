FROM docker.io/ubuntu:latest
MAINTAINER "Briezh Khenloo"


RUN mkdir -p /home/wago/ptxproj
ADD pfc-firmware-sdk/* /home/wago/ptxproj/
