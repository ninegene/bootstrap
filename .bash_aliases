alias vbash='vi ~/.bashrc'
alias sbash='source ~/.bashrc'
alias vvimrc='vi ~/.vimrc'

# enable color support
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias ll='ls -alFh  --group-directories-first'
alias llt='ll -t'
alias lls='ll -S'
alias la='ls -A'
alias l='ls -CF'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias .......='cd ../../../../../..'

alias tree='tree --charset=ASCII'
alias treel='tree --dirsfirst -FL'
alias treel2='tree --dirsfirst -FL 2'
alias treel3='tree --dirsfirst -FL 3'

alias netstatgrep='netstat -na | grep'
alias netstatL='netstat -na | grep -i "LISTEN "'
alias psgrep='ps -ef | grep'

alias www='cd ~/www'
alias alo='cd ~/www/genealo.org/public'
alias sav='cd /etc/apache2/sites-available'
alias dl='cd ~/Downloads'
alias doc='cd ~/Documents'

alias path='echo $PATH'
