#!/bin/bash

set -e
set -x

lowercase(){
  echo "$1" | sed "y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/"
}

install_mac_tools() {
  `xcode-select --install`
}

install_homebrew() {
  echo "Installing Homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

update_homebrew() {
  echo "Updating Homebrew..."
  brew update
  echo "...done"
}

brew_install_git() {
  echo "Installing git..."
  brew install git
  config_git
  echo "...done"
}

update_rubygems() {
  echo "Updating rubygems to latest version..."
  gem update --system
  echo "...done"
}

install_bundler() {
  echo "Installing bundler..."
  gem install bundler
  echo "...done"
}

install_ruby() {
  echo "Installing Ruby..."
  brew install ruby-install
  ruby-install ruby 2.2.2
  brew install chruby
  source /usr/local/share/chruby/chruby.sh
  chruby 2.2.2
  echo "...done"
}

install_rails() {
  echo "Installing rails..."
  gem install -v 4.2.1 rails
  echo "...done"
}

config_git() {
  echo "What is your GitHub username? (If you don't have one, now's a great time to come up with one!)"
  read username
  git config --global user.name "$username"

  echo "What is your GitHub email?" email
  read email
  git config --global user.email "$email"

  echo "OK, I've set up your git config"
}

setup_install_directory() {
  mkdir - p /tmp/install
  INSTALL_DIR=/tmp/install
}
  setup_install_directory
  install_mac_tools
  install_homebrew
  update_homebrew
  install_ruby
  update_rubygems
  brew_install_git
  install_bundler
  install_rails
