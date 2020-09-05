###########################################################
# version: 2.4.18
#
# Apache2 2.4.18
#
############################################################

# Use specific version to create reproducible image
FROM ninegene/ubuntu:16.04.0

# Start apache2 server on boot using /sbin/my_init
ADD ./files/apache2 /etc/my_init.d/

RUN set -x \
    && apt-get update \
    && apt-get install -y -V apache2

# Define default command.
# Use baseimage-docker's init system.
# See: https://github.com/phusion/baseimage-docker
CMD ["/sbin/my_init"]

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
