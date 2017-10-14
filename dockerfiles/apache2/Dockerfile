###########################################################
# version: 1.0.0
#
# Apache2 with letsencrypt
#
############################################################

# Use specific version to create reproducible image
FROM ninegene/ubuntu:16.04.0

# Start apache2 server on boot using /sbin/my_init
ADD ./files/apache2 /etc/my_init.d/

ADD ./files/certbot-auto /usr/bin/
ADD ./files/crontab /tmp/

RUN set -x \
    && apt-get update \
    && apt-get install -y -V apache2 \
    && a2enmod ssl proxy proxy_http xml2enc rewrite \
    && crontab /tmp/crontab \
    && /usr/bin/certbot-auto --apache --non-interactive --os-packages-only --agree-tos \
    && /usr/bin/certbot-auto --version

# Define default command.
# Use baseimage-docker's init system.
# See: https://github.com/phusion/baseimage-docker
CMD ["/sbin/my_init"]

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
