# Based on Git Prompt from fish_config, 'type fish_prompt'

set -g __fish_git_prompt_show_informative_status 1
set -g __fish_git_prompt_hide_untrackedfiles 1

set -g __fish_git_prompt_color_branch magenta bold
set -g __fish_git_prompt_showupstream "informative"
set -g __fish_git_prompt_char_upstream_ahead "↑ "
set -g __fish_git_prompt_char_upstream_behind "↓ "
set -g __fish_git_prompt_char_upstream_prefix ""

set -g __fish_git_prompt_char_stagedstate "● "
set -g __fish_git_prompt_char_dirtystate "✚ "
set -g __fish_git_prompt_char_untrackedfiles "…"
set -g __fish_git_prompt_char_conflictedstate "✖ "
set -g __fish_git_prompt_char_cleanstate "✔"

set -g __fish_git_prompt_color_dirtystate blue
set -g __fish_git_prompt_color_stagedstate yellow
set -g __fish_git_prompt_color_invalidstate red
set -g __fish_git_prompt_color_untrackedfiles $fish_color_normal
set -g __fish_git_prompt_color_cleanstate green bold

function _remote_hostname
  if test -n "$SSH_CONNECTION"
    echo "$USER@$__fish_prompt_hostname "
  end
end

function _git_status
  set -l git_status (__fish_git_prompt)
  if test -n "$git_status"
    set_color normal
    echo "$git_status"
    set_color normal
  end
end

function fish_prompt --description 'Write out the prompt'

  if not set -q __fish_prompt_hostname
      set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
  end

  if not set -q __fish_prompt_normal
    set -g __fish_prompt_normal (set_color normal)
  end

  set -l symbol '$'

  switch $USER

    case root

      if not set -q __fish_prompt_cwd
        if set -q fish_color_cwd_root
          set -g __fish_prompt_cwd (set_color $fish_color_cwd_root)
        else
          set -g __fish_prompt_cwd (set_color $fish_color_cwd)
        end
      end

      set symbol '#'

    case '*'

        if not set -q __fish_prompt_cwd
            set -g __fish_prompt_cwd (set_color $fish_color_cwd)
        end

    end

  echo -n -s (_remote_hostname) "$__fish_prompt_cwd" (prompt_pwd) (_git_status) "$symbol "

end
