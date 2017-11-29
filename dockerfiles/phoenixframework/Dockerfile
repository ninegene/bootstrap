###########################################################
# version: 1.3.0
#
# Erlang 20
# Elixir 1.5.2
# NodeJS 8.9.1
# Phoenix 1.3.0
#
############################################################

# Use specific version to create reproducible image
FROM ninegene/ubuntu:16.04.0

# Start server on boot using /sbin/my_init
ADD ./files/my_init.d/server /etc/my_init.d/

RUN set -x && \
    cd /tmp && \
    curl -Ls -o erlang-solutions_1.0_all.deb https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && \
    dpkg -i erlang-solutions_1.0_all.deb && \
    curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    apt-get update && \
    apt-get install -y -V esl-erlang elixir nodejs git vim-nox && \ 
    npm install -g brunch && \
    echo 'y' | mix local.hex && \
    echo 'y' | mix archive.install https://github.com/phoenixframework/archives/raw/master/phx_new.ez

# Define default command.
# Use baseimage-docker's init system.
# See: https://github.com/phusion/baseimage-docker
CMD ["/sbin/my_init"]

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
