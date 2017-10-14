############################################################
# version: 16.04.0
#
# Our Ubuntu base image with SSH server, cron, syslog-ng, runit, etc.
# See: https://github.com/phusion/baseimage-docker#whats-inside-the-image
#
############################################################

# Use phusion/baseimage as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/baseimage-docker/blob/master/Changelog.md for
# a list of version numbers.
FROM phusion/baseimage:0.9.22

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Enable SSH Server
# https://github.com/phusion/baseimage-docker#enabling_ssh
# RUN rm -f /etc/service/sshd/down

# Regenerate SSH host keys. baseimage-docker does not contain any, so you
# have to do that yourself. You may also comment out this instruction; the
# init system will auto-generate one during boot.
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

RUN set -x \
    && apt-get update \
    && apt-get install -y sudo vim-nox

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
