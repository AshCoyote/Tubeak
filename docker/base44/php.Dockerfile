# Runtime image for the Tubeak PHP application (development only).
# No application source is baked in: the repository is bind-mounted at
# /var/www/html by the Compose service, so edits show up immediately.
FROM php:7.4-apache

# The Debian bullseye base of this image is archived, so package lists must be
# pointed at archive.debian.org before installing the GD build dependencies.
RUN sed -i 's|deb.debian.org/debian|archive.debian.org/debian|g' /etc/apt/sources.list \
    && apt-get -o Acquire::Check-Valid-Until=false update \
    && apt-get install -y --no-install-recommends \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j"$(nproc)" mysqli gd \
    && rm -rf /var/lib/apt/lists/*

# Rewrite rules from .htaccess + legacy Order/Allow directives in sources/.htaccess
RUN a2enmod rewrite access_compat \
    && sed -ri 's/AllowOverride None/AllowOverride All/g' /etc/apache2/apache2.conf

# Uploads the platform supports are up to 4k videos.
RUN printf 'upload_max_filesize=256M\npost_max_size=256M\nmemory_limit=512M\n' \
        > /usr/local/etc/php/conf.d/zz-tubeak.ini
