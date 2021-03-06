# Note the PATH varialbe set in .profile is not loaded
# by the fish shell when logging in from ssh client
# But .profile get called from GNOME terminal of host machine

if [ "$LOADED_PROFILE" != "true" ]
    . ~/.config/fish/profile.fish
    set -x LOADED_PROFILE "true"
end

. ~/.config/fish/prompt.fish
. ~/.config/fish/aliases.fish
. ~/.config/fish/nvm.fish

if test -d "$HOME/.linuxbrew"
    set -x XDG_DATA_DIRS "$HOME/.linuxbrew/share:$XDG_DATA_DIRS"
end

if test -f ~/.config/fish/local.fish
    . ~/.config/fish/local.fish
end

set -U EDITOR "vim -f"
set -U REACT_EDITOR code
