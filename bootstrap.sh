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

# Install oh-my-zsh
/bin/bash -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Packages
brew install \
  awscli \
  fzf \
  go \
  imagemagick \
  jq \
  kubectl \
  maven \
  nvm \
  prettier \
  stow \
  the_silver_searcher \
  tmux \
  tree \
  vim \
  watch \
  yarn

# Python Environment
/usr/local/bin/pip3 install --user virtualenv
virtualenv .pyenv

# Make some default directories
mkdir ~/go

# Install dotfiles
git clone git@github.com:ethanmick/dotfiles.git ~/.dotfiles && \
  cd ~/.dotfiles && \
  stow . && \
  stow .

