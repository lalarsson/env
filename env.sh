#!/bin/bash
platform=$(uname)
os=$platform
github_pass=$1
user_pass=$2
## Check which OS
echo "Current platform is $os";

if [ "$os" != "Linux" ] && [ "$os" != "Darwin" ]
then
    echo ERROR: Platform is not supported
    exit 1
fi


if [ "$os" == "Darwin" ]
then
    # Install homebrew
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew update

    # Basic stuff for dev
    brew install git vim node brew-cask htop-osx wget Caskroom/cask/dockertoolbox unrar
    brew install tidy-html5 ssh-copy-id shellcheck Caskroom/cask/java python

    # Upgrade pip
    pip install --upgrade pip setuptools

    # Editors and shell
    brew install neovim/neovim/neovim fish Caskroom/versions/sublime-text3

    # Install browsers
    brew install Caskroom/cask/google-chrome Caskroom/cask/firefox

    # Some sweet tools
    brew install Caskroom/cask/1password Caskroom/cask/alfred Caskroom/cask/slack

    # Make sure that I own the binaries
    echo "$user_pass" | sudo -S chown -R "$USER" /usr/local/bin

    # We want fish to be default shell
    echo "$user_pass" | sudo -S chsh -s /usr/local/bin/fish "$USER"

    # We want to make sure that shell environment is as it should be
    curl -o ~/.profile https://raw.githubusercontent.com/lalarsson/env/master/.profile
    curl -o ~/.config/fish/config.fish https://raw.githubusercontent.com/lalarsson/env/master/config.fish

    # Gotta setup the docker-machine
    docker-machine create --driver virtualbox dev
fi

# Lets install Vundle for vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Now some vim settings
mkdir -p ~/.vim/colors ~/.vim/backup ~/.vim/swap ~/.vim/undo
curl -o ~/.vimrc https://raw.githubusercontent.com/lalarsson/env/master/.vimrc
curl -o ~/.vim/colors/wombat256.vim https://raw.githubusercontent.com/lalarsson/env/master/wombat256.vim

# Some stuff required for vim
pip install pep8 neovim
echo "$user_pass" | sudo -S command npm install jshint js-yaml jsonlint dockerfile_lint
echo "$user_pass" | sudo -S command gem install scss_lint mdl

# Lets install all plugins for vim
vim +PluginInstall +qall

# For easier vim usage
ln -s ~/.vim ~/.config/nvim
ln -s ~/.vimrc ~/.config/nvim/init.vim
echo "$user_pass" | sudo -S  ln -s /usr/local/bin/nvim /usr/local/bin/vim

# YouCompleteMe needs compilation
cd ~/.vim/bundle/YouCompleteMe && ./install.py

# Some git settings
curl -o ~/.gitignore https://raw.githubusercontent.com/lalarsson/env/master/.gitignore
git config --global user.name "Lars Larsson"
git config --global user.email larslarsson87@gmail.com
git config --global core.editor vim
git config --global core.excludesfile=~/.gitignore
ssh-keygen -t rsa -b 4096 -C "larslarsson87@gmail.com" -f ~/.ssh/id_rsa -q -N ""

# Going to need a new ssh key for Github
ssh=$(cat ~/.ssh/id_rsa.pub)
curl -u "lalarsson:$github_pass" --data "{\"title\":\"workkey\",\"key\":\"$ssh\"}" https://api.github.com/user/keys

