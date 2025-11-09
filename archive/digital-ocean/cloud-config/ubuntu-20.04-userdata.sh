#!/bin/bash

# Turn off history expansion to print !
set +o histexpand

username="ubuntu"
ssh_port="4444"
swap_gb="1"
swappiness="10"
timezone="America/Los_Angeles"
php_upload_max_filesize="25M"
php_post_max_size="25M"
php_max_execution_time="120"

add_user() {
    # Add user with sudo access with no password prompt
    useradd -m -d /home/${username} -s /bin/bash ${username}
    echo "${username} ALL=(ALL) NOPASSWD:ALL" | EDITOR='tee -a' visudo
    usermod -aG sudo ${username}
    mkdir /home/${username}/.ssh
    echo "
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCuxfLPQemi9kKPcyhJRAyukMThoX1JZ8oYzukHmAjdeSDbZ+p0hahn93q1QSulLuadmkUOY5gLsjHBHndVMrp8oEKSuGONvDytVARLiek+32WxCK5a6WiZ06DXeBtT30xHgJd2FZW1SdP+ysUdXp22rjOGfrNAYeymVKJwZ2ZI+sTenBLE6TyJ7xxmNRng0b3WkwQbBntXxnh9jFT0MPKd+AAXkDDW/I8hqIEJqyINZAdRbFUIAmzObqjG4otJ5G7rNmbKvzSALrFENHNH8aXrvY3s54+2XJwlDQhtSzdnt6Jx8LTCrGK2ANyn0zcsopLkolwpTZWW9Q0sJKoUISL8qZuqPTGue90e202VO8jEIHjBa4euMBqujEmjQ6BenldYnlaW4DFMIZ3HYNsItfx5KKBI6Z5GApJnpnELf0AVwiVGhP3hvVWLuTbFeSuA3NzYE5AlZREY8ZA42FCX1uOU3IjIiZjIpZMpEh8jJsxiGewCMloYGRfa2tfMr4d/3mKFJ80/JmNTvdVzxCD8+1VCvYqx0wvBuC7QBe38Vh3JC0ffKHGRp44e6jg+eE/FE/c/zVPAoSjC9DjOj1Dmwfz/tsTts8smD/naHFReyfJpj/olxGI7ZtI75fXtuIFG9UnV87FTElAwWdKMJncc5/pcpkDub7wGbMCNvx7G1SrAvQ== aung@ninegene.com
    " > /home/${username}/.ssh/authorized_keys
    chown -R ${username}:${username} /home/${username}/.ssh
    chmod 700 /home/${username}/.ssh
    chmod 600 /home/${username}/.ssh/authorized_keys

    # Disable root ssh login and change ssh port
    sed -i -e "/^#Port/s/^.*$/Port ${ssh_port}/" -e "/^Port/s/^.*$/Port ${ssh_port}/" /etc/ssh/sshd_config
    sed -i -e '/^PermitRootLogin/s/^.*$/PermitRootLogin no/' /etc/ssh/sshd_config
    sed -i -e "\$aAllowUsers ${username}" /etc/ssh/sshd_config
    systemctl restart ssh
}

install_base_packages() {
    apt upgrade -y
    apt install -y tree unzip curl wget jq mlocate unattended-upgrades
    apt install -y htop nmon netcat net-tools lsof tcpdump mtr bind9-utils openssl

    # config: /etc/fail2ban/jail.conf
    # log: /var/log/auth.log
}

install_fuzzy_finder() {
    runuser -l ${username} -c 'cd ~; git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf'
    runuser -l ${username} -c '~/.fzf/install --all'
}

config_bash() {
    echo 'if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
' | tee -a /root/.bashrc >> /home/${username}/.bashrc

    echo "
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ll='ls -al'
alias la='ls -A'
alias lla='ls -alFA'
alias l='ls -CF'
alias ds='ls -latr'
alias cls='clear'
alias sudo='sudo '
alias vi='vim'
alias v='vim -u NONE -N'
alias path='echo $PATH'
" | tee -a /root/.bash_aliases >> /home/${username}/.bash_aliases

    chown ${username}:${username} /home/${username}/.bash_aliases
}

config_git() {
    echo "
[user]
    name = ${username}
    email = ${username}@$(hostname)
[push]
    default = simple
[core]
    autocrlf = input
    editor = vim
    excludesfile = /home/${username}/.gitignore_global
[color]
    ui = true
[rerere]
    enabled = true
[alias]
    me = !git config user.name && git config user.email
    user = config user.name
    email = config user.email
    aliases = !git config --get-regexp 'alias.*' | colrm 1 6 | sed 's/[ ]/ = /'
    st = status --short --branch
    br = branch
    co = checkout
    cob = checkout -b
    unstage = reset HEAD --
    aa = !git add --all
    ci = commit -m
    cia = !git add --all && git commit -m
    amend = commit --amend
    d = diff
    dh = diff HEAD
    ds = diff --staged
    dw = diff --word-diff=color
    dhw = diff --word-diff=color HEAD
    dsw = diff --word-diff=color --staged
    last = !git ll -1 HEAD
    ls = log --abbrev-commit --date=short --pretty=format:'%C(yellow)%h %ad%Creset%Cred%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'
    ll = !git ls --name-status
    lg = log --oneline --decorate --all --graph
    changes = !sh -c 'git ll @{1}..@{0} '
    pr = !git pull -v --rebase && git changes
    fc = !git ls --follow
    fh = !git ls -u
    locallog = log --date=local
    grep = grep -i
    fname = !git ls-files | grep -i
" | tee /home/${username}/.gitconfig > /root/.gitconfig

    chown ${username}:${username} /home/${username}/.gitconfig
    chmod 640 /home/${username}/.gitconfig
    sed -i "s/${username}/root/" /root/.gitconfig
}

config_vim() {
    apt install -y vim-nox git
    runuser -l ${username} -c 'mkdir -p ~/.vim/{autoload,bundle}'
    runuser -l ${username} -c 'curl -LSso ~/.vim/autoload/pathogen.vim https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim'
    runuser -l ${username} -c 'cd ~/.vim/bundle; git clone --depth=1 https://github.com/bling/vim-airline.git'
    runuser -l ${username} -c 'cd ~/.vim/bundle; git clone --depth=1 https://github.com/tpope/vim-repeat.git'
    runuser -l ${username} -c 'cd ~/.vim/bundle; git clone --depth=1 https://github.com/tpope/vim-eunuch.git'
    runuser -l ${username} -c 'cd ~/.vim/bundle; git clone --depth=1 https://github.com/tpope/vim-endwise.git'
    runuser -l ${username} -c 'cd ~/.vim/bundle; git clone --depth=1 https://github.com/tpope/vim-surround.git'
    runuser -l ${username} -c 'cd ~/.vim/bundle; git clone --depth=1 https://github.com/tpope/vim-unimpaired.git'
    runuser -l ${username} -c 'cd ~/.vim/bundle; git clone --depth=1 https://github.com/tpope/vim-commentary.git'
    runuser -l ${username} -c 'cd ~/.vim/bundle; git clone --depth=1 https://github.com/scrooloose/syntastic.git'
    echo '
execute pathogen#infect()
execute pathogen#helptags()
syntax on
filetype plugin indent on
set nocompatible
set history=700
set syntax=on
set autoread
set hlsearch
set showmatch
set cursorline
set scrolloff=999
set ruler
set wildmenu
set laststatus=2
set wildmode=list:longest
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab
set wildmenu
set wildmode=list:longest,list:full
set wildignore+=*/tmp/*,*.swp,*.pyc,*.class
set visualbell
set hidden
set switchbuf=useopen
let mapleader = ","
let g:mapleader = ","
nmap <silent> <leader>d "_d
map <silent> <leader>d "_d
map <leader>/ :setlocal hlsearch!<CR>:set hlsearch?<CR>
map <leader>c :setlocal noignorecase!<CR>:set noignorecase?<CR>
noremap <leader>q :bp <BAR> bd #<CR>
nnoremap <C-h> "ryiw:%s/<C-r>r//gc<Left><Left><Left>
vnoremap <C-h> "ryiw:%s/<C-r>r//gc<Left><Left><Left>
" auto toggle paste
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#syntastic#enabled = 1
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
' >> /home/${username}/.vimrc
    chown ${username}:${username} /home/${username}/.vimrc
    ln -sf /home/${username}/.vimrc /root/.vimrc
    ln -sf /home/${username}/.vim /root/.vim
}

config_screen() {
    apt install -y screen
    echo '
altscreen on
termcapinfo xterm * ti @: te @
defbce on
term xterm-256color
defscrollback 30000
hardstatus alwayslastline "%{= kc}%H (load: %l) %-21<%=%D %Y-%m-%d %02c:%s"
' > /home/${username}/.screenrc
    chown ${username}:${username} /home/${username}/.screenrc
}

install_php() {
    apt install -y --no-install-recommends php php-fpm php-cli php-mysql php-json php-opcache php-mbstring php-xml php-gd php-curl
    # https://www.nginx.com/resources/wiki/start/topics/tutorials/config_pitfalls/?highlight=pitfalls#passing-uncontrolled-requests-to-php
    # Bump up max upload size for wordpress file upload
    sed -i.bak \
            -e 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' \
            -e "s/upload_max_filesize = .*/upload_max_filesize = ${php_upload_max_filesize}/" \
            -e "s/post_max_size = .*/post_max_size = ${php_post_max_size}/" \
            -e "s/max_execution_time = .*/max_execution_time = ${php_max_execution_time}/" \
            /etc/php/7.4/fpm/php.ini
    systemctl restart php7.4-fpm
}

install_wordpress_cli() {
    # Install WordPress CLI
    curl -o /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x /usr/local/bin/wp
    /usr/local/bin/wp --info
}

install_nginx() {
    apt install -y nginx certbot python3-certbot-nginx
}

install_mariadb_server() {
    # Install MariaDB 10.5
    apt install -y software-properties-common
    apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8
    add-apt-repository "deb [arch=amd64,arm64,ppc64el] http://mirror.lstn.net/mariadb/repo/10.5/ubuntu $(lsb_release -cs) main"
    apt update

    apt install -y mariadb-server

    # Enter current password for root (enter for none):
    # Switch to unix_socket authentication [Y/n] n
    # Change the root password? [Y/n] n
    # Remove anonymous users? [Y/n]
    # Disallow root login remotely? [Y/n]
    # Remove test database and access to it? [Y/n]
    # Reload privilege tables now? [Y/n]
    echo -e "\nn\nn\n\n\n\n\n" | mysql_secure_installation

    # login to root as: sudo mysql -u root
}

add_swap_space() {
    fallocate -l ${swap_gb}G /swap.1
    dd if=/dev/zero of=/swap.1 bs=1M count=$(((${swap_gb} * 1024)))
    chmod 600 /swap.1
    mkswap /swap.1
    swapon /swap.1
    echo "/swap.1 swap swap defaults 0 0" >> /etc/fstab

    # Use swap when memory is (100 - swappiness) %
    echo "vm.swappiness = ${swappiness}" >> /etc/sysctl.conf
    echo "vm.vfs_cache_pressure = 50" >> /etc/sysctl.conf
}

config_tcp_sysctl() {
    # Increase TCP Related Limits
    echo "net.core.netdev_max_backlog = 30000" >> /etc/sysctl.conf
    echo "net.ipv4.tcp_max_syn_backlog = 8096" >> /etc/sysctlconf
    echo "net.core.rmem_max = 134217728" >> /etc/sysctl.conf
    echo "net.core.wmem_max = 134217728" >> /etc/sysctl.conf
    echo "net.ipv4.tcp_rmem = 4096 87380 67108864" >> /etc/sysctl.conf
    echo "net.ipv4.tcp_wmem = 4096 87380 67108864" >> /etc/sysctl.conf
}

config_ulimit() {
    # Increase Open Files Limit
    echo "root soft nofile 4096" >> /etc/security/limits.conf
    echo "root hard nofile 10240" >> /etc/security/limits.conf
    echo "${username} soft nofile 4096" >> /etc/security/limits.conf
    echo "${username} hard nofile 10240" >> /etc/security/limits.conf
}

set_timezone() {
    timedatectl set-timezone ${timezone}
}

cleanup() {
    apt autoremove -y
}

### main ###

log_file=/var/log/cloud-init-userdata.log

# log all output to one file and to the screen
exec > >(tee ${log_file}) 2>&1

start_time=$(date +%s)
set -x

date "+%F %H:%M:%S %z"
set_timezone
date "+%F %H:%M:%S %z"

add_user
install_base_packages
install_fuzzy_finder
config_bash
config_git
config_vim
config_screen
install_php
install_wordpress_cli
install_nginx
install_mariadb_server
add_swap_space
config_tcp_sysctl
config_ulimit
cleanup

set +x
end_time=$(date +%s)

echo "$(date "+%F %H:%M:%S %z") Done. Time taken: $((${end_time} - ${start_time})) seconds"

sleep 1
reboot
