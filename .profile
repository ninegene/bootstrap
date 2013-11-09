# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

export platform=`uname`

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

if [ -d "/usr/lib/jvm/jdk7/bin" ] ; then
    export JAVA_HOME=/usr/lib/jvm/jdk7
    export IDEA_JDK=$JAVA_HOME
    PATH="$JAVA_HOME/bin:$PATH"
fi

if [ -d "/opt/groovy/bin" ] ; then
    export GROOVY_HOME=/opt/groovy
    PATH="$PATH:$GROOVY_HOME/bin"
fi

if [ -d "/opt/grails/bin" ] ; then
    export GRAILS_HOME=/opt/grails
    PATH="$PATH:$GRAILS_HOME/bin"
fi

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	      source "$HOME/.bashrc"
    fi
fi

# Adding an appropriate PATH variable for use with MacPorts.
if [ -d "/opt/local/sbin" ] ; then
    PATH="/opt/local/sbin:$PATH"
fi
if [ -d "/opt/local/bin" ] ; then
    PATH="/opt/local/bin:$PATH"
fi

# MacPorts git-core +bash_complection
if [ -f /opt/local/etc/bash_completion ]; then
    source /opt/local/etc/bash_completion
fi

# MySQL on Mac OS X
if [ -d "/opt/local/lib/mysql55/bin" ] ; then
    PATH=/opt/local/lib/mysql55/bin:$PATH
fi

# MariaDB on Mac OS X
if [ -d "/opt/local/lib/mariadb/bin" ] ; then
    PATH=/opt/local/lib/mariadb/bin:$PATH
fi

