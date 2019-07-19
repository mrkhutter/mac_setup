#!/bin/bash
set -ex

install_mac_apps() {
    if [ ! -f ~/.apps_installed ]
    then
        curl -s 'https://macapps.link/en/chrome-firefox-evernote-alfred-docker-iterm-1password-dash-flux-spectacle-spotify-voxplayer-slack' | sh
    fi
}

activate_xcode() {
    sudo xcodebuild -license
    git
}

brew_install_the_universe() {
    if [ ! -f /usr/local/bin/brew ]
    then
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi
    formulas="ruby wget ruby-install npm redis vim neovim heroku heroku-node pgcli cmake fzf openssl cmake automake autoreconf libtool postgresql yarn rbenv"
    for formula in $formulas
    do
        brew install $formula || brew upgrade $formula
    done
}

install_rubies() {
    ruby-install ruby 2.5
}

write_defaults() {
    # screenshot location
    defaults write com.apple.screencapture location $HOME/screenshots

    # no key chooser, prefering repeats instead
    # defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
}

install_go() {
    if [[ -z `which go` ]]
    then
        curl https://dl.google.com/go/go1.10.3.darwin-amd64.pkg > /tmp/go.pkg
        sudo installer -pkg /tmp/go.pkg -target /
    fi
}


install_mac_apps
activate_xcode
brew_install_the_universe
install_rubies
write_defaults
install_go

mkdir -p ~/code

if [ ! -d ~/.dotfiles ]
then
    git clone git@github.com:mrkhutter/dotfiles ~/.dotfiles
    #cd ~/.dotfiles && rake install
fi
echo "now log off"

