FROM sparkpos/php-fpm:latest
# Install Memcached
RUN curl -L -o /tmp/xhprof.tar.gz "https://github.com/longxinH/xhprof/archive/v1.1.tar.gz" && \
cd /tmp && \
mkdir -p xhprof && \
tar -C xhprof -zxvf /tmp/xhprof.tar.gz --strip 1 && \
( \
    cd xhprof && \
    phpize && \
    ./configure --with-php-config=/usr/local/bin/php-config && \
    make -j$(nproc) && \
    make install \
) && \
rm /tmp/xhprof* && \
docker-php-ext-enable xhprof