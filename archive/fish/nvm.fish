# see: https://github.com/oh-my-fish/plugin-foreign-env
if test -d "$HOME/.config/fish/plugin-foreign-env/functions"
    set fish_function_path $fish_function_path $HOME/.config/fish/plugin-foreign-env/functions

    if test -s ~/.nvm/nvm.sh
        # see: https://github.com/derekstavis/plugin-nvm/blob/master/init.fish
        set -q NVM_DIR; or set -gx NVM_DIR ~/.nvm
        fenv source $NVM_DIR/nvm.sh >/dev/null ^&1
    end

    # see: https://github.com/derekstavis/plugin-nvm/blob/master/functions/nvm.fish
    function nvm -d "Node version manager"
        if test -e $NVM_DIR/nvm.sh
            fenv source $NVM_DIR/nvm.sh\; nvm $argv
        else
            echo "You need to install nvm"
            return 1
        end
    end
end
