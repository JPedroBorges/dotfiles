#! /bin/bash

[ -z $1 ] && echo "Missing passphrase" && exit 1

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

echo "configuring ssh"
ssh-keygen -t ed25519 -C "joao.borges@fanduel.com" -N "$1" -f ~/.ssh/github_id_ed25519

echo "cloning dotfiles"
git clone https://github.com/JPedroBorges/dotfiles.git "${HOME}/.dotfiles"
ln -s "${HOME}/.dotfiles/joao.borges/.zshrc" "${HOME}/.zshrc"
ln -s "${HOME}/.dotfiles/joao.borges/.p10k.zsh" "${HOME}/.p10k.zsh"
ln -s "${HOME}/.dotfiles/joao.borges/.gitconfig" "${HOME}/.gitconfig"
ln -s "${HOME}/.dotfiles/joao.borges/Library/Application Support/Code/User/settings.json" "${HOME}/Library/Application Support/Code/User/settings.json"
ln -s "${HOME}/.dotfiles/joao.borges/Library/DBeaverData/workspace6/General/.dbeaver/data-sources.json" "${HOME}/Library/DBeaverData/workspace6/General/.dbeaver/data-sources.json"
ln -s "${HOME}/.dotfiles/joao.borges/.ssh/config" "${HOME}/.ssh/config"
ln -s "${HOME}/.dotfiles/joao.borges/Library/Application Support/iTerm2/DynamicProfiles/joao.borges.json" "${HOME}/Library/Application Support/iTerm2/DynamicProfiles/joao.borges.json"

printf "TODO:\n\
\tconfigure: \n\
\t\tGitHub: SSH Key (pbcopy < ~/.ssh/github_id_ed25519.pub) \n\
\t\tIntellij: File | Manage IDE Settings | Import Settings | intellij/settings.zip \n\
\t\tCertificates: https://fanduel.atlassian.net/wiki/spaces/~674092252/pages/308064945548/macos+starter+guide
\n
\tinstall: \n\
\t\tAmphetamine (https://apps.apple.com/pt/app/amphetamine/id937984704?mt=12)  \n\
\t\tClipy (https://clipy-app.com)  \n\
\t\tMaven@3.6.3 (https://repo.maven.apache.org/maven2/org/apache/maven/apache-maven/3.6.3) to \"/opt/apache-maven\"  \n\
"