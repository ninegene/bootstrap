set -U EDITOR vim

if test -d '/usr/lib/jvm/jdk7/bin'
  set -x JAVA_HOME /usr/lib/jvm/jdk7
  set -x IDEA_JDK /usr/lib/jvm/jdk7
  set -x $PATH $JAVA_HOME/bin
end

. ~/.config/fish/fish_prompt.fish
. ~/.config/fish/aliases.fish

if test -f ~/.config/fish/local.fish
  # configs local to machine or not applicable to all machines
  # Share it with Dropbox
  # ln -s ~/Dropbox/fish/machine1.fish ~/.config/fish/local.fish
  . ~/.config/fish/local.fish
end

