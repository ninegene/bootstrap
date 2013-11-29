set -U EDITOR vim

# add to front of path
function prepand_to_path
  if test -d $argv[1]; and not contains $argv[1] $PATH
    set -x PATH $argv[1] $PATH
  else
    echo $argv[1] is not directory or already contains in PATH
  end
end

# add to end of path
function append_to_path
  if test -d $argv[1]; and not contains $argv[1] $PATH
    set -x $PATH $argv[1]
  else
    echo $argv[1] is not directory or already contains in PATH
  end
end

if test -d '/usr/lib/jvm/jdk7/bin'
  set -x JAVA_HOME /usr/lib/jvm/jdk7
  set -x IDEA_JDK /usr/lib/jvm/jdk7
  prepand_to_path $JAVA_HOME/bin
end

# MacPorts path
if test -d '/opt/local/bin'
  prepand_to_path /opt/local/bin
end
if test -d '/opt/local/sbin'
  prepand_to_path /opt/local/sbin
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

