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
alias tree1='tree --dirsfirst -FL 1'
alias tree2='tree --dirsfirst -FL 2'
alias tree3='tree --dirsfirst -FL 3'
alias tree4='tree --dirsfirst -FL 4'

alias path='echo -e ${PATH//:/\\n}'

alias now='date +"%T'
alias nowtime=now
alias nowdate='date +"%d-%m-%Y"'

alias h='history'
alias c='clear'
alias j='jobs -l'

# mkdir <dir>
alias mkdir='mkdir -pv'

# Generate sha1 digest
# sha1 <file>
alias sha1='openssl sha1' 

# sudo apt-get install colordiff
# diff <file1> <file2>
alias diff='colordiff'

# Make mount command output pretty and human readable format
alias mount='mount |column -t'

# Start calculator with math support
alias bc='bc -l'

# Show TCP/UDP ports
alias ports='netstat -tulanp'

# Show Listening/Server ports
alias lports='netstat -nap | grep -i "LISTEN "'

# Get web server headers #
# header <url>
alias header='curl -I'
 
# Find out if remote server supports gzip / mod_deflate or not #
# headerc <url>
alias headerc='curl -I --compress'
 
# Resume wget by default
alias wget='wget -c'

# Get free memory in MB
alias meminfo='free -m -l -t'

# Get disk usage
alias df='df -hT'

# Get directory size
# ds <dir>
alias ds='du -sh'
 
# Get top process eating memory
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
 
# Get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'
 
# Get info
alias cpuinfo='lscpu' # cat /proc/cpuinfo
alias usbinfo='lsusb' # 
alias modinfo='lsmod' # cat /proc/modules
 
# Get GPU ram on desktop / laptop
alias gpumeminfo='grep -i --color memory /var/log/Xorg.0.log'

if [ -f ~/.bash_local ]; then
    . ~/.bash_local
fi
 
alias vvimrc='vi ~/.vimrc'
alias vbasha='vi ~/.bash_aliases'
alias vbashrc='vi ~/.bashrc'
alias sbashrc='source ~/.bashrc'

alias sav='cd /etc/apache2/sites-available'
