#!/bin/bash

# Setup my Mac's basic dev environment. Clear and concise.
set -e

echo "Root, please!"
sudo -v

# Setup developer tools
xcode-select --install
read -n 1 -p "Press any key when developer tools have been installed..." 

# Install Docker from Mac
open https://docs.docker.com/docker-for-mac/install/

# Wait for installation to finish... and then test
read -n 1 -p "press any key when done..." 
docker run hello-world
if [ $? -ne 0 ]; then
    echo "Docker installation failed!"
fi
echo "Docker install finished, continuing..."

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Make some default directories
mkdir ~/go
mkdir -p ~/.vim/tmp

# Install Packages
brew install \
  awscli \
  fzf \
  go \
  gpg \
  imagemagick \
  jq \
  kubectl \
  maven \
  nvm \
  pipx \
  prettier \
  stow \
  the_silver_searcher \
  tmux \
  tree \
  vim \
  watch \
  yarn

# Setup Vundle for vim, once we install it.
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

# Python Environment
pipx install virtualenv
virtualenv .pyenv

# Install dotfiles
git clone git@github.com:ethanmick/dotfiles.git ~/.dotfiles && \
  cd ~/.dotfiles && \
  stow . && \
  stow .

# Install oh-my-zsh
/bin/bash -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# And done
exit
