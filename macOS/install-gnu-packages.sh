#!/bin/bash
set -euo pipefail

UNINSTALL_FIRST=false

brew_install() {
    local pkg=$1

    if [[ ${UNINSTALL_FIRST} == 'true' ]]; then
        (
            set -x
            brew uninstall --force "${pkg}"
        )
    fi

    if brew list -1 | grep -q "^${pkg}\$"; then
        set +e
        brew upgrade "${pkg}"
        set -e
    else
        (
            set -x
            brew install "$@"
        )
    fi
}

brew_install_pkgs() {
    # GNU packages
    brew_install coreutils # GNU ls, readlink etc.
    brew_install findutils # GNU find, locate, updatedb, xargs

    brew_install diffutils # GNU diff, cmp, diff3, sdiff
    brew_install wdiff
    brew_install gawk
    brew_install gnu-indent
    brew_install gnu-sed
    brew_install gnu-tar
    brew_install gnu-which
    brew_install gnutls
    brew_install grep
    brew_install screen
    brew_install wget
    brew_install gzip
    brew_install watch
    brew_install tree
    brew_install make       # GNU make (gmake → make via gnubin)
    brew_install gnu-getopt # GNU getopt with long-option support (keg-only)
    brew_install gnu-time   # GNU time with memory/CPU stats
    brew_install parallel   # GNU parallel
    brew_install bc         # GNU bc arbitrary-precision calculator
}

main() {
    brew_install_pkgs

    echo "$(basename $0): Done."
}

# Uninstall and install brew pkgs
reset() {
    UNINSTALL_FIRST=true
    brew_install_pkgs
}

${1-main}
