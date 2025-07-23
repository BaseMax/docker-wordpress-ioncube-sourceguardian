FROM wordpress:php8.1

RUN apt-get update -y && \
    apt-get install -y wget curl libxml2-dev nano zip unzip htop screenfetch neofetch && \
    docker-php-ext-install soap && \
    rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/BaseMax/php-installer-ioncube-sourceguardian/raw/refs/heads/main/install_loaders.php && \
    php install_loaders.php && \
    rm install_loaders.php
