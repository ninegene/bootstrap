set -U EDITOR vim

# Note the PATH varialbe set in .profile is not loaded
# by the fish shell when logging in from ssh client
# But .profile get called from GNOME terminal of host machine

. ~/.config/fish/profile.fish
. ~/.config/fish/prompt.fish
. ~/.config/fish/aliases.fish

# Source local.fish if exists
if test -f ~/.config/fish/local.fish
  # configs local to machine or not applicable to all machines
  # Share it with Dropbox:
  # $ ln -s ~/Dropbox/fish/machine1.fish ~/.config/fish/local.fish
  . ~/.config/fish/local.fish
end

