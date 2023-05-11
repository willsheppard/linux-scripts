#!/bin/bash

# https://stackoverflow.com/a/54851251

BASE_DIR="$1"
if [ -z "$BASE_DIR" ]
then
    echo "usage: $0 [base_dir]"
    exit 1
fi

# Strict mode
set -euo pipefail

function do_sdk {
    cd $BASE_DIR
    mkdir android-sdk
    cd android-sdk
    wget https://dl.google.com/android/repository/commandlinetools-linux-6200805_latest.zip
    unzip commandlinetools-linux-*_latest.zip
    yes | ./tools/bin/sdkmanager --sdk_root=$(pwd) "build-tools;28.0.3" "emulator" "platform-tools" "platforms;android-29" "tools" "cmdline-tools;latest"
}

# Doesn't seem to work
function do_flutter {
    cd $BASE_DIR
    wget -nc https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_v1.12.13+hotfix.8-stable.tar.xz
    tar xvf flutter_linux_v1.12.13+hotfix.8-stable.tar.xz
}

function do_flutter2 {
    sudo snap install flutter --classic
    flutter # updates itself when first run
    yes | flutter doctor --android-licences
}

function do_env {
    export ANDROID_SDK=$BASE_DIR/android-sdk
    export ANDROID_PATH=$ANDROID_SDK/tools:$ANDROID_SDK/platform-tools
    export FLUTTER=$BASE_DIR/flutter/bin
    export PATH=$PATH:$ANDROID_PATH:$FLUTTER

#    source ~/.bashrc
}

# Start
do_sdk
#do_flutter
do_flutter2
do_env

