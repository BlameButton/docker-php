FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive
ARG CHROME_URL="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
ARG PACKAGES="php7.4-cli php7.4-curl php7.4-dom php7.4-mysql php7.4-zip curl wait-for-it libglib2.0-0 libnss3 libx11-6"

# - Update existing packages
# - Clean left deb's
# - Install PHP and Google Chrome
# - Clean up Google Chrome installer and apt cache
RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get clean && \
    apt-get install -y ${PACKAGES} && \
    curl --no-progress-meter --output google-chrome.deb "${CHROME_URL}" && \
    apt-get install -y ./google-chrome.deb && \
    rm google-chrome.deb && \
    rm -rf /var/lib/apt/lists/* 

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php --install-dir=/usr/local/bin --filename=composer && \
    rm composer-setup.php

WORKDIR /app

CMD [ "bash" ]
