FROM php:8.2-apache

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

# Install 
RUN apt-get update && apt-get install --no-install-recommends -y \
    git \
    curl \
    nano \
    libzip-dev \
    libxml2-dev \
    libpng-dev \
    libonig-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libssl-dev \
    libmcrypt-dev \
    libicu-dev \
    libxslt-dev \
    apt-utils \
    pngquant \
    mariadb-client \
    zip \
    unzip \
    exif

RUN pecl install zip pcov 
RUN /usr/local/bin/docker-php-ext-install exif
RUN docker-php-ext-enable zip  \
    && docker-php-ext-enable exif \
    && /usr/local/bin/docker-php-ext-install pdo \
    && /usr/local/bin/docker-php-ext-install pdo_mysql \
    && /usr/local/bin/docker-php-ext-install mysqli \
    && /usr/local/bin/docker-php-ext-install bcmath \
    && /usr/local/bin/docker-php-ext-install soap \
    && /usr/local/bin/docker-php-ext-install gd \
    && /usr/local/bin/docker-php-ext-install intl \
    && /usr/local/bin/docker-php-source delete \
    && docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/ \
    && docker-php-ext-configure intl 


# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Enable Apache mod_rewrite desenvolvimento
RUN a2enmod rewrite && a2enmod headers && a2enmod ssl && a2ensite dev
# RUN a2enmod rewrite && a2enmod headers && a2ensite dev

# Install Composer PHP
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

RUN docker-php-ext-install calendar

WORKDIR /var/www/

RUN chown -R ${UID}:${GID} /var/www/html/ && chmod -R 777 /var/www/

# RUN echo $URL
CMD ["apachectl", "-D", "FOREGROUND"] 