FROM wordpress:latest

RUN apt-get update && apt-get install -y wget unzip tar

RUN wget https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz && \
    tar -xzf ioncube_loaders_lin_x86-64.tar.gz && \
    PHP_VER=$(php -r "echo PHP_MAJOR_VERSION.'.'.PHP_MINOR_VERSION;") && \
    cp "ioncube/ioncube_loader_lin_${PHP_VER}.so" "$(php -r 'echo ini_get("extension_dir");')" && \
    echo "zend_extension=ioncube_loader_lin_${PHP_VER}.so" > /usr/local/etc/php/conf.d/00-ioncube.ini && \
    rm -rf ioncube*


RUN wget https://www.sourceguardian.com/loaders/download/loaders.linux-x86_64.tar.gz && \
    tar -xzf loaders.linux-x86_64.tar.gz && \
    PHP_VER=$(php -r "echo PHP_MAJOR_VERSION.'.'.PHP_MINOR_VERSION;") && \
    cp "ixed.${PHP_VER}.lin" "$(php -r 'echo ini_get("extension_dir");')" && \
    echo "zend_extension=ixed.${PHP_VER}.lin" > /usr/local/etc/php/conf.d/01-sourceguardian.ini && \
    rm -rf loaders* ixed*

RUN apt-get clean && rm -rf /var/lib/apt/lists/*
