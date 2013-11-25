
alias G 'gvim'

alias ll 'ls -alFh --group-directories-first'
alias la 'ls -A'

alias grep 'grep --color=auto'
alias fgrep 'fgrep --color=auto'
alias egrep 'egrep --color=auto'

alias ... 'cd ../..'
alias .... 'cd ../../..'

alias eali 'vi ~/.config/fish/aliases.fish'
alias sali '. ~/.config/fish/aliases.fish'
alias efish 'vi ~/.config/fish/config.fish'
alias sfish '. ~/.config/fish/config.fish'
alias ev 'vi ~/.vimrc'

# sudo apt-get install tree
# sudo port install tree
alias tree='tree --charset=ASCII'
alias tree1='tree --dirsfirst -FL 1'
alias tree2='tree --dirsfirst -FL 2'
alias tree3='tree --dirsfirst -FL 3'

alias path 'echo $PATH'

alias timestamp 'date +"%F-%s"'

alias h 'history'
alias c 'clear'
alias j 'jobs -l'

#alias sha1 'openssl sha1'
alias sha1 'shasum'
alias md5 'md5sum'

which colordiff > /dev/null; and alias diff 'colordiff'

# Show public facing ip
alias publicip "dig +short myip.opendns.com @resolver1.opendns.com"

# Show TCP/UDP ports
alias ports 'netstat -tulan'

# Show Listening/Server ports
alias lports 'netstat -na | grep -i "LISTEN "'

# Get web server headers #
# $ header <url>
alias header 'curl -I'

# Find out if remote server supports gzip / mod_deflate or not #
# $ headerc <url>
alias headerc 'curl -I --compress'

# Resume wget by default
alias wget 'wget -c'

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
#alias show "defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
#alias hide "defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

alias sav 'cd /etc/apache2/sites-available'
alias dl 'cd ~/Downloads'
alias p 'cd ~/Projects'

