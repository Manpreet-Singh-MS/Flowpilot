set -e

# White
msg() {
    echo -e "$@"
}

# Yellow
info() {
    printf "\033[1;33m$@\033[0m\n"
}

# Green
success() {
    printf "\033[0;32m$@\033[0m\n"
}

# Red
fail() {
    printf "\033[0;31m$@\033[0m\n"
    exit 1
}

# install android and java sdk
sudo apt update
sudo apt install -y openjdk-11-jdk git
wget -q --show-progress --no-clobber --tries=5 https://dl.google.com/android/repository/commandlinetools-linux-8092744_latest.zip
unzip commandlinetools-linux-8092744_latest.zip
mkdir -p ~/Android/Sdk/cmdline-tools/latest
mv cmdline-tools/* ~/Android/Sdk/cmdline-tools/latest/
rm -rf cmdline-tools
echo 'export ANDROID_SDK_ROOT=$HOME/Android/Sdk' >> ~/.bashrc
echo 'export PATH=$PATH:$HOME/Android/Sdk/cmdline-tools/latest/bin' >> ~/.bashrc
source ~/.bashrc
sdkmanager --install "platform-tools"
sdkmanager --install "build-tools;32.0.0"

# get python 3.9
DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata
sudo apt install -y software-properties-common
yes | sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt install -y python3.9 python3.9-dev python3.9-distutils 

# get flowpilot
cd ~/ && git clone https://github.com/flowdriveai/flowpilot.git
cd flowpilot && git submodule update --init

pip install pipenv

