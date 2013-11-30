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
    set -x PATH $PATH $argv[1]
  else
    echo $argv[1] is not directory or already contains in PATH
  end
end

# JAVA_HOME in Linux
if test -d '/usr/lib/jvm/jdk7/bin'
  set -x JAVA_HOME /usr/lib/jvm/jdk7
  prepand_to_path $JAVA_HOME/bin
end

# JAVA_HOME in Mac
# TODO

# IntelliJ IDEA for Linux
if test -d '/opt/idea/bin'
  set -x IDEA_JDK $JAVA_HOME
  append_to_path /opt/idea/bin
end

# SmartGitHg git/hg ui client for Linux
if test -d '/opt/smartgithg/bin'
  set -x SMARTGIT_JAVA_HOME $JAVA_HOME
  append_to_path /opt/smartgithg/bin
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

