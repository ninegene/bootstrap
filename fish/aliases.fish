switch (uname -s)
  case Darwin
    alias myip "ifconfig en0 | grep 'inet ' | awk '{ print $2; }' | sed 's/\/.*\$//'"
    alias mycopy 'pbcopy'
    alias mypaste 'pbpaste'

    alias ls 'ls -CFG'
    alias ll 'ls -alFh | command grep "^d"; and ls -alFh | grep -v "^d"'

    # gls from gnu's coreutils, needs 'brew install coreutils'
    type gls > /dev/null 2>&1; and alias ls 'gls -CF --color=auto'
    type gls > /dev/null 2>&1; and alias ll 'gls -alFh --color=auto --group-directories-first'

    # Show/hide hidden files in Finder
    alias showfiles "defaults write com.apple.finder AppleShowAllFiles -bool true; killall Finder"
    alias hidefiles "defaults write com.apple.finder AppleShowAllFiles -bool false; killall Finder"

  case Linux
    alias myip "hostname -I"
    alias mycopy 'xclip -selection clipboard'
    alias mypaste 'xclip -selection clipboard -o'

    alias ls 'ls -CF --color=auto'
    alias ll 'ls -alFh --group-directories-first'

    # list old files/dirs first
    alias lr 'ls -alFhtr'

    # Don't allow to remove root directory
    alias rm 'rm --preserve-root'
end

alias la 'ls -A'
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

# echo one line per path
function path
  for p in $PATH
    echo $p
  end
end

alias h 'history'
alias j 'jobs -l'

type colordiff > /dev/null 2>&1; and alias diff 'colordiff'
type shasum > /dev/null 2>&1; or alias shasum 'openssl sha1'
type md5sum > /dev/null 2>&1; or alias md5sum 'openssl md5'

alias cpsshkey 'mycopy < ~/.ssh/id_rsa.pub'

# Show public facing ip
alias pubip "dig +short myip.opendns.com @resolver1.opendns.com"

# Show Listening/Server ports
alias lports 'netstat -na | command grep "LISTEN "'

# Resume wget by default
alias wget 'wget -c'

# Get disk usage
alias df 'df -h'

# Get directory size
# e.g. ds <dir>
alias ds 'du -sh'

# Edit fish aliases, config, local and source config
alias ea 'vi ~/.config/fish/aliases.fish'
alias el 'vi ~/.config/fish/local.fish'
alias sf 'source ~/.config/fish/config.fish'

alias doc 'cd ~/Documents'
alias dl 'cd ~/Downloads'
alias dr 'cd ~/Dropbox'

# Print Upper-case Env Variable (ignore case)
function pe
  set -l x (echo $argv | tr 'a-z' 'A-Z')
  echo $x
  printenv $x
end

function idea
   /opt/idea/bin/idea.sh ~/Projects/$argv[1]
end

function fport --description "Find process pid listening upon a port. e.g. fport <port>"
    sudo fuser $argv[1]/tcp
    sudo lsof -i :$argv[1]
    sudo netstat -tulpn | grep :$argv[1]
end

function fpid --description "Find pid info. e.g. fpid <pid>"
    for a in $argv
        sudo ls -l /proc/$a/exe
        sudo ls -l /proc/$a/cwd
        #sudo pwdx $a
        echo ""
        echo "cat /proc/$a/environ | tr '\0' '\n' | sort"
        cat /proc/$a/environ | tr '\0' '\n' | sort
        echo ""
    end
    echo ""
    echo -e "pid\tuser\tgroup\targs\tetime\tlstart"
    sudo ps -eo pid,user,group,args,etime,lstart | egrep "^\s+$argv "
    echo ""
    sudo ps aux | command grep " $argv " | grep -v "grep  $argv " | command grep --color=auto " $argv "
end

