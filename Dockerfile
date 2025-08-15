# Max Base
# https://github.com/BaseMax/docker-wordpress-ioncube-sourceguardian
# https://github.com/docker-library/wordpress/blob/6b67cd46375883e2e25d218736ce936f93aca3b2/latest/php8.1/apache/Dockerfile

ARG WORDPRESS_PHP_IMAGE=php8.1
FROM wordpress:${WORDPRESS_PHP_IMAGE}

RUN apt-get update -y && \
    apt-get install -y \
    wget sudo curl libxml2-dev nano zip unzip htop screenfetch \
    libzip-dev libpng-dev libjpeg-dev libfreetype6-dev libonig-dev \
    libssl-dev libcurl4-openssl-dev libicu-dev libreadline-dev \
    vim less lsof net-tools dnsutils iputils-ping git iproute2 \
    && docker-php-ext-install zip intl pdo_mysql mbstring curl soap \
    && pecl install redis \
    && docker-php-ext-enable redis \
    && rm -rf /var/lib/apt/lists/*

RUN cat > /usr/local/etc/php/conf.d/memory-limit.ini <<EOF
memory_limit = 4G
upload_max_filesize = 512M
post_max_size = 1024M
max_execution_time = 90000
max_input_time = 300
max_input_vars = 5000
max_file_uploads = 50
EOF

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

RUN wget https://raw.githubusercontent.com/BaseMax/php-installer-ioncube-sourceguardian/main/install_loaders.php && \
    php install_loaders.php && rm install_loaders.php

RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer
