# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

JAVA_HOME=/usr/lib/jvm/jdk7
if [ -d "$JAVA_HOME/bin" ] ; then
    export $JAVA_HOME
    PATH="$JAVA_HOME/bin:$PATH"
fi

GROOVY_HOME=/opt/groovy
if [ -d "$GROOVY_HOME/bin" ] ; then
    export $GROOVY_HOME
    PATH="$PATH:$GROOVY_HOME/bin"
fi

GRAILS_HOME=/opt/grails
if [ -d "$GRAILS_HOME/bin" ] ; then
    export $GRAILS_HOME
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

