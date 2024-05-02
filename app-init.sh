#!/bin/bash

export QUARTO_VERSION="1.4.553"

mkdir -p /opt/quarto/${QUARTO_VERSION}

 curl -o quarto.tar.gz -L \
    "https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-amd64.tar.gz"

tar -zxvf quarto.tar.gz \
    -C "/opt/quarto/${QUARTO_VERSION}" \
    --strip-components=1

rm quarto.tar.gz

if [ -f "/usr/local/bin/quarto" ]; then
    rm /usr/local/bin/quarto
fi

ln -s /opt/quarto/${QUARTO_VERSION}/bin/quarto /usr/local/bin/quarto

# /opt/quarto/"${QUARTO_VERSION}"/bin/quarto check

quarto tools install chromium

apt update

# libgtk-3.0
apt install -y libnss3 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libxkbcommon-x11-0 \
    libxcomposite-dev \
    libxrandr2 \
    libgtk-3-0 \
    libasound2 \
    libgl1 \
    libgbm-dev \
    libreoffice

apt-get install -y \
    fonts-arphic-ukai \
    fonts-arphic-uming \
    fonts-ipafont-mincho \
    fonts-ipafont-gothic \
    fonts-unfonts-core

quarto check
