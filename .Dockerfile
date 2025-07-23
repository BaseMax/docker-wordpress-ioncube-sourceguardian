# https://github.com/docker-library/wordpress/blob/6b67cd46375883e2e25d218736ce936f93aca3b2/latest/php8.1/apache/Dockerfile
FROM wordpress:php8.1

RUN apt-get update -y && \
    apt-get install -y wget curl libxml2-dev nano zip unzip htop screenfetch neofetch && \
    docker-php-ext-install soap && \
    rm -rf /var/lib/apt/lists/*

RUN rm -f install_loaders.php && \
    wget https://raw.githubusercontent.com/BaseMax/php-installer-ioncube-sourceguardian/main/install_loaders.php && \
    php install_loaders.php && \
    rm install_loaders.php
