set -U EDITOR vim

# Note the PATH varialbe set in .profile is loaded by the fish shell as well

# add to front of path
function prepand_to_path
  set -x PATH $argv[1] $PATH
end

# add to end of path
function append_to_path
  set -x PATH $PATH $argv[1]
end

# SmartGitHg git/hg ui client for Linux
if test -d '/opt/smartgithg/bin'
  set -x SMARTGIT_JAVA_HOME "$JAVA_HOME"
  append_to_path /opt/smartgithg/bin
end

# MacPorts path
if test -d '/opt/local/bin'
  prepand_to_path /opt/local/bin
end
if test -d '/opt/local/sbin'
  prepand_to_path /opt/local/sbin
end

if test -d '/opt/local/lib/mariadb/bin'
  prepand_to_path /opt/local/lib/mariadb/bin
end

. ~/.config/fish/fish_prompt.fish
. ~/.config/fish/aliases.fish

# Source local.fish if exists
if test -f ~/.config/fish/local.fish
  # configs local to machine or not applicable to all machines
  # Share it with Dropbox:
  # $ ln -s ~/Dropbox/fish/machine1.fish ~/.config/fish/local.fish
  . ~/.config/fish/local.fish
end

