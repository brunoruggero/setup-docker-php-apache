FROM php:7.4-apache
# FROM php:7.4-fpm

ARG UID=www-data
ARG GID=www-data
ARG URL
ENV URL ${URL}
ARG URL_ALIAS
ENV URL_ALIAS ${URL_ALIAS}

COPY ./ /var/www/html
COPY ./docker/apache /etc/apache2/sites-available
COPY ./docker/php/php.ini /usr/local/etc/php/php.ini
COPY --chown=${UID}:${GID} ./docker/ssl /var/imported/ssl

# en_US config
RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 
ENV LANG en_US.UTF-8

# # Install
RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y  libfreetype6-dev libjpeg62-turbo-dev apt-utils pngquant libpng-dev nano curl libssl-dev libmcrypt-dev libicu-dev libxml2-dev libonig-dev git libxslt-dev libzip-dev zip unzip \
    && docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/ \
    && /usr/local/bin/docker-php-ext-install zip bcmath gd xml xmlrpc dom session intl mysqli pdo_mysql  mbstring soap opcache xsl pdo pdo_mysql

# Enable Apache mod_rewrite desenvolvimento
RUN a2enmod rewrite && a2enmod headers && a2enmod ssl && a2ensite dev
# RUN a2enmod rewrite && a2enmod headers && a2ensite dev

# Install Composer PHP
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

RUN docker-php-ext-install calendar

WORKDIR /var/www/
# RUN mkdir -p /var/www/moodledata

# VOLUME /moodledata

RUN chown -R ${UID}:${GID} /var/www/html/ && chmod -R 777 /var/www/

# RUN echo $URL
CMD ["apachectl", "-D", "FOREGROUND"] 