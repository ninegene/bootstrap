set -U EDITOR vim

. ~/.config/fish/fish_prompt.fish
. ~/.config/fish/aliases.fish

if test -f ~/.config/fish/local.fish
  # configs local to machine or not applicable to all machines
  # Share it with Dropbox
  # ln -s ~/Dropbox/fish/machine1.fish ~/.config/fish/local.fish
  . ~/.config/fish/local.fish
end

