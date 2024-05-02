FROM python:3.9

# 前提パッケージのインストール
RUN apt-get update \
    && apt-get install -y less vim curl unzip gettext-base jq yq zip \
    && ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime


WORKDIR /workdir

# Install Quarto
COPY --chmod=755 app-init.sh ./
RUN ./app-init.sh
