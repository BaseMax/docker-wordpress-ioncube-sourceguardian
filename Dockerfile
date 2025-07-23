# https://github.com/docker-library/wordpress/blob/6b67cd46375883e2e25d218736ce936f93aca3b2/latest/php8.1/apache/Dockerfile
ARG WORDPRESS_PHP_IMAGE=php8.1
FROM wordpress:${WORDPRESS_PHP_IMAGE}

RUN apt-get update -y && \
    apt-get install -y \
    wget curl libmcrypt-dev libxml2-dev nano zip unzip htop screenfetch neofetch \
    libzip-dev libpng-dev libjpeg-dev libfreetype6-dev libonig-dev \
    libssl-dev libcurl4-openssl-dev libicu-dev libreadline-dev \
    vim less lsof net-tools dnsutils iputils-ping git iproute2 \
    && docker-php-ext-install zip intl pdo_mysql mbstring curl soap \
    && pecl install mcrypt redis \
    && docker-php-ext-enable redis \
    && echo "extension=mcrypt.so" > /usr/local/etc/php/conf.d/mcrypt.ini \
    && rm -rf /var/lib/apt/lists/*

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

RUN wget https://raw.githubusercontent.com/BaseMax/php-installer-ioncube-sourceguardian/main/install_loaders.php && \
    php install_loaders.php && rm install_loaders.php
