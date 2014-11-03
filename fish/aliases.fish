# Enable aliases to be sudo'ed
alias sudo 'sudo '

switch (uname -s)
  case Darwin
    #alias updatedb 'sudo /usr/libexec/locate.updatedb' # available in gnu's findutils
    alias mycopy 'pbcopy'
    alias mypaste 'pbpaste'
    # gls from gnu's coreutils
    alias ls 'gls -CF --color=auto'
    alias ll 'gls -alFh --color=auto --group-directories-first'
  case Linux
    alias mycopy 'xclip -selection clipboard'
    alias mypaste 'xclip -selection clipboard -o'
    alias ls 'ls -CF --color=auto'
    alias ll 'ls -alFh --group-directories-first'
end

alias la 'ls -A'
alias lh 'ls -lt | head'
alias lls 'll -S'
alias llt 'll -t'

alias grep 'grep --color=auto'
alias fgrep 'fgrep --color=auto'
alias egrep 'egrep --color=auto'

alias .. 'cd ..'
alias ... 'cd ../..'
alias .... 'cd ../../..'

alias tree='tree --charset=ASCII'
alias tree1='tree --dirsfirst -FL 1'
alias tree2='tree --dirsfirst -FL 2'
alias tree3='tree --dirsfirst -FL 3'

#alias path 'echo $PATH'
function path
  for p in $PATH
    echo $p
  end
end

alias timestamp 'date +"%F-%s"'

alias h 'history'
alias c 'clear'
alias j 'jobs -l'

function fname
  command find . -iname "*$argv*"
end

function psgrep
  command ps axuf | grep -v grep | grep "$argv" -i --color=auto
end

alias mkdir 'mkdir -pv'

alias sha1 'shasum'
alias md5 'md5sum'
which shasum > /dev/null; and alias sha1 'openssl sha1'
which md5sum > /dev/null; and alias md5 'openssl md5'

which colordiff > /dev/null; and alias diff 'colordiff'

#alias mount 'mount |column -t'

# Show public facing ip
alias publicip "dig +short myip.opendns.com @resolver1.opendns.com"
alias myip "ip addr show eth0 | grep inet | awk '{ print $2; }' | sed 's/\/.*\$//'"
alias myip2 "hostname -I"

# Show TCP/UDP ports
alias ports 'netstat -tulan'

# Show Listening/Server ports
alias lports 'netstat -na | grep "LISTEN "'
alias lports2 'sudo netstat -tnlp'

# Get web server headers #
# $ header <url>
alias header 'curl -I'

# Find out if remote server supports gzip / mod_deflate or not #
# $ headerc <url>
alias headerc 'curl -I --compress'

# Resume wget by default
alias wget 'wget -c'

# e.g. ngrephttp eth0
function ngrephttp
  command sudo ngrep -d $argv[1] -t '^(GET|POST) ' 'tcp and port 80'
end

# e.g. httpdump en0
function httpdump
  command sudo tcpdump -i $argv[1] -n -s 0 -w - | grep -a -o -E "Host\: .*|GET \/.*"
end

function tn -d "Create a tunnel \n  tn <user@remote_host> <remote_port> <local_port>"
  command ssh $argv[1] -T -L $argv[3]:localhost:$argv[2]
end

# Get free memory in MB
alias meminfo 'free -m -l -t'

# Get disk usage
alias df 'df -h'

# Get directory size
# $ ds <dir>
alias ds 'du -sh'

# Get top process eating memory
alias psmem 'ps aux | sort -nr -k 4'
alias psmem3 'ps aux | sort -nr -k 4 | head -3'
alias psmem10 'ps aux | sort -nr -k 4 | head -10'

# Get top process eating cpu
alias pscpu 'ps aux | sort -nr -k 3'
alias pscpu3 'ps aux | sort -nr -k 3 | head -3'
alias pscpu10 'ps aux | sort -nr -k 3 | head -10'

# Linux: Get info
alias cpuinfo 'lscpu' # cat /proc/cpuinfo
alias usbinfo 'lsusb' #
alias modinfo 'lsmod' # cat /proc/modules
alias pciinfo 'lspci' #

# Mac: Show/hide hidden files in Finder
alias showfiles "defaults write com.apple.finder AppleShowAllFiles -bool true; killall Finder"
alias hidefiles "defaults write com.apple.finder AppleShowAllFiles -bool false; killall Finder"

alias ea 'vim ~/.config/fish/aliases.fish'
alias ef 'vim ~/.config/fish/config.fish'
alias el 'vim ~/.config/fish/local.fish'
alias ev 'vim ~/.vimrc'
alias sfish '. ~/.config/fish/config.fish'

alias sav 'cd /etc/apache2/sites-available'
alias doc 'cd ~/Documents'
alias dl 'cd ~/Downloads'
alias dr 'cd ~/Dropbox'
alias p 'cd ~/Projects'

alias cpsshkey 'xclip -sel clip < ~/.ssh/id_rsa.pub'
alias sshkey 'cat ~/.ssh/id_rsa.pub'

alias bfg 'java -jar ~/dotfiles/bin/bfg.jar'
