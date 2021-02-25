FROM alpine:latest
MAINTAINER S. David

RUN apk --update add\
    autoconf automake axel\
    ccache gcc g++ git\
    libexecinfo-dev musl-dev\
    sdl2-dev sdl2_image-dev

RUN addgroup -S developer &&\
    adduser -S -D -h /home/developer developer developer &&\
    chgrp -R developer /usr/local && chmod -R g+rw /usr/local &&\
    mkdir -pv /var/run/ccache &&\
    chgrp -R developer /var/run/ && chmod -R g+rw /var/run/

WORKDIR /home/developer
USER developer

RUN ccache -o cache_dir=/var/run/ccache/ && ccache -o max_size=1.0G &&\
    mkdir -pv ~/Developer ~/Downloads

RUN cd ~/Downloads && axel -a -n 3 \
    "http://www.ferzkopp.net/Software/SDL2_gfx/SDL2_gfx-1.0.4.tar.gz" &&\
    tar xvf SDL2_gfx-1.0.4.tar.gz && cd SDL_gfx-1.0.4/ &&\
    mkdir -pv build && cd build &&\
    ../configure CC="ccache gcc" CXX="ccache g++" &&\
    make -j 3 install

WORKDIR /home/developer/Developer


# vim:set et sts=4 sw=4 ts=8:
