FROM php:7.1-apache-stretch

RUN apt update && \
    apt install -y -q --no-install-recommends mysql-client  && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install -j"$(nproc)" pdo_mysql

COPY ./oauth-vhost.conf  /etc/apache2/sites-available/
RUN a2enmod rewrite && \
    a2ensite oauth-vhost.conf
