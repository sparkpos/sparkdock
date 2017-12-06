FROM laradock/php-fpm:1.4-71

MAINTAINER Terry Zhang <zterry@qq.com>

#
#--------------------------------------------------------------------------
# Mandatory Software's Installation
#--------------------------------------------------------------------------
#
# Mandatory Software's such as ("mcrypt", "pdo_mysql", "libssl-dev", ....)
# are installed on the base image 'laradock/php-fpm' image. If you want
# to add more Software's or remove existing one, you need to edit the
# base image (https://github.com/Laradock/php-fpm).
#

#
#--------------------------------------------------------------------------
# Optional Software's Installation
#--------------------------------------------------------------------------
#
# Optional Software's will only be installed if you set them to `true`
# in the `docker-compose.yml` before the build.
# Example:
#   - INSTALL_ZIP_ARCHIVE=true
#
#####################################
# Sockets:
#####################################
USER root
ARG INSTALL_SOCKETS=true
ENV INSTALL_SOCKETS ${INSTALL_SOCKETS}
RUN if [ ${INSTALL_SOCKETS} = true ]; then \
    docker-php-ext-install sockets && \
    docker-php-ext-enable sockets \
;fi
#####################################
# SOAP:
#####################################

ARG INSTALL_SOAP=false
RUN if [ ${INSTALL_SOAP} = true ]; then \
    # Install the soap extension
    apt-get update -yqq && \
    apt-get -y install libxml2-dev php-soap && \
    docker-php-ext-install soap \
;fi

#####################################
# pgsql
#####################################

ARG INSTALL_PGSQL=false
RUN if [ ${INSTALL_PGSQL} = true ]; then \
    # Install the pgsql extension
    apt-get update -yqq && \
    docker-php-ext-install pgsql \
;fi

#####################################
# pgsql client
#####################################

ARG INSTALL_PG_CLIENT=false
RUN if [ ${INSTALL_PG_CLIENT} = true ]; then \
    # Install the pgsql client
    apt-get update -yqq && \
    apt-get install -y postgresql-client \
;fi

#####################################
# xDebug:
#####################################

ARG INSTALL_XDEBUG=false
RUN if [ ${INSTALL_XDEBUG} = true ]; then \
    # Install the xdebug extension
    pecl install xdebug && \
    docker-php-ext-enable xdebug \
;fi

# Copy xdebug configuration for remote debugging
COPY ./xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini

#####################################
# PHP REDIS EXTENSION FOR PHP 7.0
#####################################

ARG INSTALL_PHPREDIS=true
RUN if [ ${INSTALL_PHPREDIS} = true ]; then \
    # Install Php Redis Extension
    printf "\n" | pecl install -o -f redis \
    &&  rm -rf /tmp/pear \
    &&  docker-php-ext-enable redis \
;fi

#####################################
# Swoole EXTENSION FOR PHP 7
#####################################

ARG INSTALL_SWOOLE=false
RUN if [ ${INSTALL_SWOOLE} = true ]; then \
    # Install Php Swoole Extension
    pecl install swoole \
    &&  docker-php-ext-enable swoole \
;fi

#####################################
# MongoDB:
#####################################

ARG INSTALL_MONGO=false
RUN if [ ${INSTALL_MONGO} = true ]; then \
    # Install the mongodb extension
    pecl install mongodb && \
    docker-php-ext-enable mongodb \
;fi

#####################################
# ZipArchive:
#####################################

ARG INSTALL_ZIP_ARCHIVE=true
RUN if [ ${INSTALL_ZIP_ARCHIVE} = true ]; then \
    # Install the zip extension
    docker-php-ext-install zip \
;fi

#####################################
# bcmath:
#####################################

ARG INSTALL_BCMATH=true
RUN if [ ${INSTALL_BCMATH} = true ]; then \
    # Install the bcmath extension
    docker-php-ext-install bcmath \
;fi

#####################################
# PHP Memcached:
#####################################

ARG INSTALL_MEMCACHED=true
RUN if [ ${INSTALL_MEMCACHED} = true ]; then \
    # Install the php memcached extension
    curl -L -o /tmp/memcached.tar.gz "https://github.com/php-memcached-dev/php-memcached/archive/php7.tar.gz" \
    && mkdir -p memcached \
    && tar -C memcached -zxvf /tmp/memcached.tar.gz --strip 1 \
    && ( \
        cd memcached \
        && phpize \
        && ./configure \
        && make -j$(nproc) \
        && make install \
    ) \
    && rm -r memcached \
    && rm /tmp/memcached.tar.gz \
    && docker-php-ext-enable memcached \
;fi

#####################################
# Exif:
#####################################

ARG INSTALL_EXIF=false
RUN if [ ${INSTALL_EXIF} = true ]; then \
    # Enable Exif PHP extentions requirements
    docker-php-ext-install exif \
;fi


#####################################
# Opcache:
#####################################

ARG INSTALL_OPCACHE=true
RUN if [ ${INSTALL_OPCACHE} = true ]; then \
    docker-php-ext-install opcache \
;fi

# Copy opcache configration
COPY ./opcache.ini /usr/local/etc/php/conf.d/opcache.ini

#####################################
# Mysqli Modifications:
#####################################

ARG INSTALL_MYSQLI=true
RUN if [ ${INSTALL_MYSQLI} = true ]; then \
    docker-php-ext-install mysqli \
;fi

#####################################
# Tokenizer Modifications:
#####################################

ARG INSTALL_TOKENIZER=true
RUN if [ ${INSTALL_TOKENIZER} = true ]; then \
    docker-php-ext-install tokenizer \
;fi

#####################################
# Human Language and Character Encoding Support:
#####################################

ARG INSTALL_INTL=false
RUN if [ ${INSTALL_INTL} = true ]; then \
    # Install intl and requirements
    apt-get update -yqq && \
    apt-get install -y zlib1g-dev libicu-dev g++ && \
    docker-php-ext-configure intl && \
    docker-php-ext-install intl \
;fi

#####################################
# LDAP:
#####################################

ARG INSTALL_LDAP=false
RUN if [ ${INSTALL_LDAP} = true ]; then \
    apt-get update -yqq && \
    apt-get install -y libldap2-dev && \
    docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ && \
    docker-php-ext-install ldap \
;fi

#####################################
# Image optimizers:
#####################################
USER root
ARG INSTALL_IMAGE_OPTIMIZERS=false
ENV INSTALL_IMAGE_OPTIMIZERS ${INSTALL_IMAGE_OPTIMIZERS}
RUN if [ ${INSTALL_IMAGE_OPTIMIZERS} = true ]; then \
    apt-get update -yqq && \
    apt-get install -y --force-yes jpegoptim optipng pngquant gifsicle \
;fi

#####################################
# ImageMagick:
#####################################
USER root
ARG INSTALL_IMAGEMAGICK=false
ENV INSTALL_IMAGEMAGICK ${INSTALL_IMAGEMAGICK}
RUN if [ ${INSTALL_IMAGEMAGICK} = true ]; then \
    apt-get update -y && \
    apt-get install -y libmagickwand-dev imagemagick && \ 
    pecl install imagick && \
    docker-php-ext-enable imagick \
;fi

#####################################
# xhprof:
#####################################
USER root
RUN apt-get update -y && \
    apt-get install -y git && \ 
    cd /tmp && \
    git clone https://github.com/longxinH/xhprof.git && \
    cd /tmp/xhprof && \
    git checkout 50a129ea22fabf1cd3cf2fa544c0a124050e353c && \
    cd /tmp/xhprof/extension && \
    /usr/local/bin/phpize && \
    ./configure --with-php-config=/usr/local/bin/php-config && \
    make && \
    make install && \
    apt-get remove -y git && \
    rm -rf /tmp/* 
    
#
#--------------------------------------------------------------------------
# Final Touch
#--------------------------------------------------------------------------
#

ADD ./laravel.ini /usr/local/etc/php/conf.d
ADD ./xhprof.ini /usr/local/etc/php/conf.d
ADD ./xlaravel.pool.conf /usr/local/etc/php-fpm.d/

#RUN rm -r /var/lib/apt/lists/*

RUN usermod -u 1000 www-data

WORKDIR /var/www

CMD ["php-fpm"]

EXPOSE 9001
