FROM alpine:latest


ARG SHINOBI_BRANCH=master
ARG BUILDROOT_BRANCH=2024.05

RUN echo "https://dl-cdn.alpinelinux.org/alpine/latest-stable/community" >> /etc/apk/repositories

RUN apk add --update --update-cache \
    busybox ca-certificates alpine-sdk \
    diffutils gcc g++ busybox dpdk-acl \
    linux-headers fakeroot fakeroot-dbg \
    bash patch openssl wget \
    ncurses ncurses-libs ncurses-dev \
    curl git gzip bzip2 \
    perl tar cpio unzip \
    rsync file bc\
    bsd-compat-headers autoconf \
    findutils ffmpeg mysql-client \
    py3-pip python3 npm binutils \
    build-base musl musl-dev musl-utils musl-libintl \
    make dpkg cmake libcap \
    gcompat

RUN apk add --update --update-cache \
    glade mercurial dropbear-scp openssh-sftp-server \
    subversion asciidoc w3m \
    graphviz py3-matplotlib 


# RUN ln -sf python3 /usr/bin/python \
#   && python3 -m ensurepip \
#    && pip3 install --no-cache --upgrade pip setuptools \
#    && rm -rf /var/cache/apk/*  # Clean up to reduce image size

 # RUN git clone --branch $SHINOBI_BRANCH https://gitlab.com/Shinobi-Systems/Shinobi.git /opt/shinobi
 RUN git clone --branch $BUILDROOT_BRANCH https://gitlab.com/buildroot.org/buildroot.git /home/buildroot

#These are our custom configs, pulled from https://github.com/IronOxidizer/instant-pi/
 RUN git clone https://github.com/IronOxidizer/instant-pi.git /home/buildroot/instant-pi

 # WORKDIR /opt/shinobi
 # RUN npm install && npm install pm2 -g

 # WORKDIR /home/Shinobi



 WORKDIR /home/buildroot
 COPY buildrootConfigs/rpi0w_quickboot_shinobi_defconfig /home/buildroot/configs/rpi0w_quickboot_shinobi_defconfig
 # RUN rm packages/fakeroot/fakeroot.mk

 #COPY buildrootConfigs/genimage-instantpi0w.cfg /opt/buildroot/genimage-instantpi0w.cfg

 # RUN ln -s /home/buildroot/instant-pi/instant-pi-0w/instantpi0w_defconfig /home/buildroot/configs/instantpi0w_defconfig

 # Lets fix buildroot
 # We're gonna bump our buildroot to Fakeroot 3.35.1, to avoid compatibility issues with musl.

 WORKDIR /home/buildroot/package/fakeroot
 COPY buildrootConfigs/fakeroot.mk /home/buildroot/package/fakeroot/fakeroot.mk
 COPY buildrootCOnfigs/fakeroot.hash /home/buildroot/package/fakeroot/fakeroot.hash


# We need to run this first to finalize buildroot configuration
# RUN make raspberrypi0w_defconfig && make
# RUN make rpi0w_quickboot_shinobi_config && make

 COPY entrypoint.sh /entrypoint.sh
 RUN chmod +x /entrypoint.sh

 EXPOSE 18444

ENTRYPOINT ["/entrypoint.sh"]
