# https://github.com/phusion/baseimage-docker
FROM phusion/baseimage:0.9.15
MAINTAINER Shinichi Ohno

# Set correct environment variables.
# ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive

# Regenerate SSH host keys. baseimage-docker does not contain any, so you
# have to do that yourself. You may also comment out this instruction; the
# init system will auto-generate one during boot.
# RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# basic settings
RUN echo "LANG=\"en_GB.UTF-8\"" > /etc/default/locale
RUN locale-gen en_GB.UTF-8
RUN dpkg-reconfigure locales

RUN apt-get update
RUN apt-get install -y build-essential wget curl git

# ffmpeg
## Enable Universe and Multiverse and install dependencies.
RUN echo deb http://archive.ubuntu.com/ubuntu precise universe multiverse >> /etc/apt/sources.list; apt-get update; apt-get -y install autoconf automake build-essential libass-dev libgpac-dev libtheora-dev libtool libvdpau-dev libvorbis-dev pkg-config texi2html zlib1g-dev libmp3lame-dev wget; apt-get clean

## Fetch Sources
RUN cd /usr/local/src; git clone http://git.videolan.org/git/x264.git; git clone https://github.com/mstorsjo/fdk-aac.git; git clone https://chromium.googlesource.com/webm/libvpx; git clone http://git.videolan.org/git/ffmpeg.git; wget http://downloads.xiph.org/releases/opus/opus-1.0.3.tar.gz; wget http://www.tortall.net/projects/yasm/releases/yasm-1.2.0.tar.gz;

## Build YASM assembler.
RUN cd /usr/local/src; tar xzvf yasm-1.2.0.tar.gz; cd yasm-1.2.0; ./configure; make -j 4; make install; make distclean;

## Build libx264
RUN cd /usr/local/src/x264; ./configure --enable-static; make -j 4; make install; make distclean

## Build libfdk-aac
RUN cd /usr/local/src/fdk-aac; autoreconf -fiv; ./configure --disable-shared; make -j 4; make install; make distclean

## Build libvpx
RUN cd /usr/local/src/libvpx; ./configure --disable-examples; make -j 4; make install; make clean

## Build libopus
RUN cd /usr/local/src; tar zxvf opus-1.0.3.tar.gz; cd opus-1.0.3; ./configure --disable-shared; make -j 4; make install; make distclean

## Build ffmpeg.
RUN cd /usr/local/src/ffmpeg; ./configure --extra-libs="-ldl" --enable-gpl --enable-libass --enable-libfdk-aac --enable-libmp3lame --enable-libopus --enable-libtheora --enable-libvorbis --enable-libvpx --enable-libx264 --enable-nonfree; make -j 4; make install; make distclean;

# imagemagick
RUN apt-get install -y imagemagick

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
hash -r
