set -U EDITOR vim

function add_path
  if test -d $argv[1]; and not contains $argv[1] $PATH
    set -x PATH $argv[1] $PATH
  else
    echo $argv[1] is not directory or already contains in PATH
  end

end

. ~/.config/fish/fish_prompt.fish
. ~/.config/fish/aliases.fish

if test -f ~/.config/fish/local.fish
  # configs local to machine or not applicable to all machines
  # Share it with Dropbox
  # ln -s ~/Dropbox/fish/machine1.fish ~/.config/fish/local.fish
  . ~/.config/fish/local.fish
end

