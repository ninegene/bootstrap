#!/bin/sh
set -ex

disable_screenoff_when_inactive() {
    # Don't turn screen off when inactive
    gsettings set org.gnome.desktop.session idle-delay 0

    # Turn screen off when inactive for 5 min
    # gsettings set org.gnome.desktop.session idle-delay 300
}

enable_4_workspaces_in_a_square() {
    # Enable 4 workspaces in a square
    gsettings set org.compiz.core:/org/compiz/profiles/unity/plugins/core/ hsize 2
    gsettings set org.compiz.core:/org/compiz/profiles/unity/plugins/core/ vsize 2

    # Disable workspaces
    # gsettings set org.compiz.core:/org/compiz/profiles/unity/plugins/core/ hsize 1
    # gsettings set org.compiz.core:/org/compiz/profiles/unity/plugins/core/ vsize 1
}

disable_unity_online_search() {
    gsettings set com.canonical.Unity.Lenses remote-content-search 'none'
}

disable_screen_lock() {
    gsettings set org.gnome.desktop.screensaver lock-enabled false
}

disable_overlay_scroll_bar() {
    gsettings set com.canonical.desktop.interface scrollbar-mode normal

    # Enable Overlay Scroll Bar
    # gsettings reset com.canonical.desktop.interface scrollbar-mode
}

show_menu_windows_title_bar() {
    gsettings set com.canonical.Unity integrated-menus true
    #gsettings reset com.canonical.Unity integrated-menus
}

set_unity_dash_scopes() {
    gsettings set com.canonical.Unity.Dash scopes "['home.scope', 'applications.scope', 'files.scope', 'video.scope', 'music.scope', 'photos.scope']"
    #gsettings reset com.canonical.Unity.Dash scopes
    gsettings set com.canonical.Unity.Lenses disabled-scopes \
        "['recipes-gourmet.scope', 'more_suggestions-amazon.scope', 'more_suggestions-u1ms.scope', 'more_suggestions-populartracks.scope', 'music-musicstore.scope', 'more_suggestions-ebay.scope', 'more_suggestions-ubuntushop.scope', 'more_suggestions-skimlinks.scope']"
}

remove_ubuntuone() {
    sudo apt-get purge oneconf oneconf-common python-oneconf python3-oneconf \
        python-ubuntu-sso-client ubuntu-sso-client ubuntu-sso-client-qt \
        ubuntuone-client-data
    sudo apt-get autoremove
}

remove_account_plugins() {
    sudo apt-get purge account-plugin-* libaccount-plugin-*
    sudo apt-get autoremove
}

remove_mail_clients() {
    sudo apt-get purge evolution-data-server* thunderbird*
    sudo apt-get autoremove
}

# Last tested with 14.04.4 LTS
main() {
    disable_screenoff_when_inactive
    enable_4_workspaces_in_a_square
    disable_unity_online_search
    disable_screen_lock
    disable_overlay_scroll_bar
    show_menu_windows_title_bar
    set_unity_dash_scopes

    remove_ubuntuone
    remove_account_plugins
    remove_mail_clients
}

${1-main}
