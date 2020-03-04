FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive
ARG CHROME_URL="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
ARG PACKAGES="php7.4-cli php7.4-dom php7.4-zip php7.4-curl curl libglib2.0-0 libnss3 libx11-6"

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get clean && \
    apt-get install -y ${PACKAGES} && \
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    curl --no-progress-meter --output google-chrome.deb "${CHROME_URL}" && \
    apt-get install -y ./google-chrome.deb && \
    rm -rf /var/lib/apt/lists/* 

RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer && rm composer-setup.php
WORKDIR /app

CMD [ "bash" ]