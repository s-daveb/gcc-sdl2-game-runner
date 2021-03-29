# README.md
A dockerfile used to test sdaveb/quartz-warriors project. 

## Overview
### Container Overview:
1. Update APK repository
2. Install all needed APKs
3. Create a developer user, with limited /usr/local/ and /var/run write access.
4. Switch to developer user
5. Configure ccache
6. Download necessary dependency source
7. Compile dependencies
8. Install dependencies

### APKs to install
* autoconf
* automake
* axel
* ccache
* gcc
* g++
* git
* libexecinfo-dev
* make
* musl-dev
* sdl2-dev
* sdl2_image-dev

#### SDL2_gfx installation process:

1. Use axel to download sources to ~/Downloads
2. tar xvf  sources.tar.gz
3. cd source
4. mkdir build && cd build
5. ../configure CC="ccache gcc" CXX="ccache g++" 
6. make -j -l 4
7. make install
