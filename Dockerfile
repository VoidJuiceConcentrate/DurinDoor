FROM alpine:latest


ARG SHINOBI_BRANCH=master
ARG BUILDROOT_BRANCH=master

RUN echo "https://dl-cdn.alpinelinux.org/alpine/latest-stable/community" >> /etc/apk/repositories

RUN apk add --update --update-cache \
    which sed ca-certificates \
    diffutils gcc g++ busybox \
    linux-headers fakeroot fakeroot-dbg \
    bash patch openssl wget \
    ncurses ncurses-libs ncurses-dev \
    curl git gzip bzip2 \
    perl tar cpio unzip \
    rsync file bc\
    bsd-compat-headers autoconf \
    findutils ffmpeg mysql-client \
    py3-pip python3 npm binutils \
    build-base musl musl-dev 

# RUN ln -sf python3 /usr/bin/python \
#   && python3 -m ensurepip \
#    && pip3 install --no-cache --upgrade pip setuptools \
#    && rm -rf /var/cache/apk/*  # Clean up to reduce image size

 RUN git clone --branch $SHINOBI_BRANCH https://gitlab.com/Shinobi-Systems/Shinobi.git /opt/shinobi
 RUN git clone --branch $BUILDROOT_BRANCH https://gitlab.com/buildroot.org/buildroot.git /opt/buildroot
 RUN git clone https://github.com/IronOxidizer/instant-pi.git /opt/buildroot/instant-pi

 WORKDIR /opt/shinobi
 RUN npm install && npm install pm2 -g

 WORKDIR /home/Shinobi

 #These are our custom configs, pulled from https://github.com/IronOxidizer/instant-pi/

 WORKDIR /opt/buildroot
 #COPY buildrootConfigs/rpi0w_quickboot_shinobi_defconfig /opt/buildroot/configs/rpi0w_quickboot_shinobi_defconfig
 #COPY buildrootConfigs/genimage-instantpi0w.cfg /opt/buildroot/genimage-instantpi0w.cfg


# We need to run this first to finalize buildroot configuration
# RUN make raspberrypi0w_defconfig && make
# RUN make rpi0w_quickboot_shinobi_config && make


 COPY entrypoint.sh /entrypoint.sh
 RUN chmod +x /entrypoint.sh

 EXPOSE 18444

ENTRYPOINT ["/entrypoint.sh"]
