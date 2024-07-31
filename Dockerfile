FROM node:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive

# ARG SHINOBI_BRANCH=master
ARG BUILDROOT_BRANCH=2024.05

RUN apt-get update && apt-get install -y \
    ca-certificates build-essential \
    diffutils gcc g++ \
    linux-source \
    patch openssl wget \
    ncurses-base ncurses-bin \
    curl git gzip bzip2 \
    perl tar cpio unzip \
    rsync file bc ncurses-dev \
    autoconf python3-matplotlib \
    findutils ffmpeg default-mysql-client \
    python3-pip python3 npm binutils \
    graphviz
    

RUN apt-get install -y \
    glade mercurial openssh-sftp-server \
    subversion asciidoc w3m \
    && rm -rf /var/lib/apt/lists/* # Cleanup


# RUN ln -sf python3 /usr/bin/python \
#   && python3 -m ensurepip \
#    && pip3 install --no-cache --upgrade pip setuptools \
#    && rm -rf /var/cache/apk/*  # Clean up to reduce image size

 # RUN git clone --branch $SHINOBI_BRANCH https://gitlab.com/Shinobi-Systems/Shinobi.git /opt/shinobi
  RUN mkdir /home/buildroot && chown 1000:1000 /home/buildroot
  RUN mkdir /home/buildrootOutput

  USER node

  RUN git clone --branch $BUILDROOT_BRANCH https://gitlab.com/buildroot.org/buildroot.git /home/buildroot

  


#These are our custom configs, pulled from https://github.com/IronOxidizer/instant-pi/
 RUN git clone https://github.com/IronOxidizer/instant-pi.git /tmp/instant-pi

 WORKDIR /home/buildroot
 
 RUN mkdir /home/buildroot/board/rpi0w_quickboot
 
 # Now some buildrooot stuff

 COPY buildrootConfigs/rpi0w_quickboot/* /home/buildroot/board/rpi0w_quickboot/
 RUN cp /tmp/instant-pi/instant-pi-0w/cmdline.txt /home/buildroot/board/rpi0w_quickboot/
 RUN cp /tmp/instant-pi/instant-pi-0w/config.txt /home/buildroot/board/rpi0w_quickboot/
 COPY buildrootConfigs/genimage-rpi0w_quickboot.cfg /home/buildroot/board/rpi0w_quickboot/genimage.cfg.in
 COPY buildrootConfigs/linux_rpi0w_quickboot_defconfig /home/buildroot/configs/linux_rpi0w_quickboot_defconfig

 # RUN rm packages/fakeroot/fakeroot.mk

# Adding user to run buildroot

 # Entrypoint management
 USER root
 RUN rm -rf /tmp/instant-pi
 COPY entrypoint.sh /entrypoint.sh
 RUN chmod +x /entrypoint.sh

 # EXTERNAL port
 EXPOSE 18444

ENTRYPOINT ["/entrypoint.sh"]
