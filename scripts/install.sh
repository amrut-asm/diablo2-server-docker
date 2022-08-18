#!/bin/bash
export LANG=C.UTF-8
export D2GS_PARENT_DIR="/root/.wine/drive_c/Program Files"

export DEBIAN_FRONTEND="noninteractive"
export TZ="UTC"
dpkg --add-architecture i386
apt-get update

# Install wine dependencies
apt-get install -y libjpeg-dev:i386 \
libpng-dev:i386 \
libgnutls28-dev:i386 \
libxml2-dev:i386 \
libxslt1-dev:i386 \
gettext

# Install build/misc tools
apt-get install -y \
    curl \
    wget \
    build-essential \
    flex \
    bison \
    xz-utils \
    gcc-multilib \
    git \
    netbase \
    ca-certificates \
    gcc g++ \
    libc6-dev libc6 \
    libc++-dev libc++1  \
    zlib1g-dev zlib1g \
    libcurl4-openssl-dev libcurl4 \
    cmake make supervisor unrar gettext-base

# Clone pvpgn code
git clone --single-branch --branch "develop" "https://github.com/pvpgn/pvpgn-server.git" pvpgn-server
cd pvpgn-server

# Build pvpgn
cmake -G "Unix Makefiles" -S./ -B./build \
    -DWITH_BNETD="true" \
    -DWITH_D2CS="true" \
    -DWITH_D2DBS="true" \
    -DWITH_LUA="false" \
    -DWITH_MYSQL="false" \
    -DWITH_SQLITE3="false" \
    -DWITH_PGSQL="false" \
    -DWITH_ODBC="false"
cd build
make -j$(nproc)

# Install pvpgn
make install

# Get wine 2.0.1 source
cd /root
wget http://dl.winehq.org/wine/source/2.0/wine-2.0.1.tar.xz
tar xf wine-2.0.1.tar.xz
wget https://gist.githubusercontent.com/HarpyWar/cd3676fa4916ea163c50/raw/50fbbff9a310d98496f458124fac14bda2e16cf0/sock.c -O wine-2.0.1/server/sock.c
mkdir -p /root/wine-2.0.1/build

# Build wine 2.0.1
cd /root/wine-2.0.1/build
../configure --without-x --without-freetype
make -j$(nproc)

# Install wine
make install

# Initialize wine
winecfg

# Download D2GS and required files
cd "$D2GS_PARENT_DIR"
mkdir d2gs
cd d2gs
wget http://cdn.pvpgn.pro/diablo2/1.13c/D2Client.dll
wget http://cdn.pvpgn.pro/diablo2/1.13c/D2CMP.dll
wget http://cdn.pvpgn.pro/diablo2/1.13c/D2Common.dll
wget http://cdn.pvpgn.pro/diablo2/1.13c/D2Game.dll
wget http://cdn.pvpgn.pro/diablo2/1.13c/D2gfx.dll
wget http://cdn.pvpgn.pro/diablo2/1.13c/D2Lang.dll
wget http://cdn.pvpgn.pro/diablo2/1.13c/D2MCPClient.dll
wget http://cdn.pvpgn.pro/diablo2/1.13c/D2Net.dll
wget http://cdn.pvpgn.pro/diablo2/1.13c/D2sound.dll
wget http://cdn.pvpgn.pro/diablo2/1.13c/D2Win.dll
wget http://cdn.pvpgn.pro/diablo2/1.13c/Fog.dll
wget http://cdn.pvpgn.pro/diablo2/1.13c/Storm.dll
wget http://cdn.pvpgn.pro/diablo2/1.13c/Patch_D2.mpq
wget http://cdn.pvpgn.pro/diablo2/ijl11.dll
wget http://cdn.pvpgn.pro/diablo2/d2speech.mpq
wget http://cdn.pvpgn.pro/diablo2/d2data.mpq
wget http://cdn.pvpgn.pro/diablo2/d2sfx.mpq
wget http://cdn.pvpgn.pro/diablo2/d2exp.mpq
wget https://cdn.pvpgn.pro/d2gs/D2GS-113c-build03.rar
unrar x D2GS-113c-build03.rar
rm D2GS-113c-build03.rar d2gs.reg

# Clean directories
rm -rf /var/lib/apt/lists/* /pvpgn-server /build/pvpgn-server /root/wine-2.0.1* /usr/local/var/pvpgn /usr/local/etc/pvpgn

# Re-create pvpgn directories
mkdir -p /usr/local/var/pvpgn
mkdir -p /usr/local/etc/pvpgn

# Clean apt cache
apt-get clean