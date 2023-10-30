#! /bin/bash

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo "Hello $(whoami)! Let's get you set up."

echo "installing xcode"
xcode-select --install

echo "create projects folder"
mkdir -p ${HOME}/worksapce/{repository,ideas,courses}

echo "installing homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "installing apps"
brew install --cask \
intellij-idea \
visual-studio-code \
postman \
dbeaver-community \
cyberduck \
docker \
iterm2 \
github \
spotify \
bitwarden \
rectangle

brew tap sdkman/tap

brew install \
node \
nvm \
yarn \
sdkman-cli \
wireshark

echo "installing oh my zsh"
cp fonts/* /Library/Fonts

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k