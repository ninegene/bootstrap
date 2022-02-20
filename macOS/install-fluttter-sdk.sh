#!/bin/bash
set -eo pipefail

install_flutter() {
    (set -x
    # Based on: https://docs.flutter.dev/get-started/install/macos
    cd /tmp
    curl -L https://storage.googleapis.com/flutter_infra_release/releases/stable/macos/flutter_macos_2.8.1-stable.zip -o flutter-stable.zip
    rm -rf flutter
    unzip flutter-stable.zip
    if [[ -d /usr/local/opt/flutter ]]; then
        rm -rf /usr/local/opt/flutter
    fi
    mv flutter /usr/local/opt/
    )
}

after_install() {
    (set -x
    /usr/local/opt/flutter/bin/flutter --version
    /usr/local/opt/flutter/bin/dart --version
    /usr/local/opt/flutter/bin/flutter config --no-analytics
    )

    # shellcheck disable=SC2016
    echo '

Add the flutter tool to your path:

    export PATH="$PATH:/usr/local/opt/flutter/bin"

To develop Flutter apps for iOS, you need a Mac with Xcode installed.
Also see:
    https://docs.flutter.dev/get-started/install/macos#install-xcode
    '
}

install_flutter
after_install
