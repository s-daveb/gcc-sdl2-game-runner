FROM alpine:latest
MAINTAINER S. David

RUN apk --update add\
    autoconf automake axel\
    ccache gcc g++ git\
    libexecinfo-dev make musl-dev\
    sdl2-dev sdl2_image-dev

RUN adduser -s /bin/sh -D -h /home/developer developer developer &&\
    chgrp -Rv developer /usr/local && chmod -Rv g+rw /usr/local &&\
    mkdir -pv /var/run/ccache &&\
    chgrp -Rv developer /var/run/ && chmod -Rv g+rw /var/run/

WORKDIR /home/developer
USER developer

RUN ccache -o cache_dir=/var/run/ccache/ && ccache -o max_size=1.0G &&\
    mkdir -pv ~/Developer ~/Downloads

RUN cd ~/Downloads && axel -a -n 3 \
    "http://www.ferzkopp.net/Software/SDL2_gfx/SDL2_gfx-1.0.4.tar.gz" &&\
    tar xvf SDL2_gfx-1.0.4.tar.gz && cd SDL2_gfx-1.0.4/ &&\
    mkdir -pv build && cd build &&\
    ../configure CC="ccache gcc" CXX="ccache g++" &&\
    make -j 3 install

WORKDIR /home/developer/Developer


# vim:set et sts=4 sw=4 ts=8:
