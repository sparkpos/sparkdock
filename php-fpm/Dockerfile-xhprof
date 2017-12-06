FROM sparkpos/php-fpm:latest
# Install Memcached
RUN curl -L -o /tmp/xhprof.tar.gz "https://github.com/longxinH/xhprof/archive/v1.1.tar.gz" && \
cd /tmp && \
mkdir -p xhprof && \
tar -C xhprof -zxvf /tmp/xhprof.tar.gz --strip 1 && \
( \
    cd xhprof/extension && \
    phpize && \
    ./configure --with-php-config=/usr/local/bin/php-config && \
    make -j$(nproc) && \
    make install \
) && \
rm -rf /tmp/xhprof* && \
docker-php-ext-enable xhprof && \
echo 'xhprof.output_dir = /var/www/xhprof' >> /usr/local/etc/php/conf.d/docker-php-ext-xhprof.ini

VOLUME /var/www/xhprof