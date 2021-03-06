#!/bin/sh
set -e

#brew cask install kitty

cd ~/.zk_vimrc
mkdir -p ~/.config/nvim/
echo ' 
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc

' > ~/.config/nvim/init.vim

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo '
 so ~/.zk_vimrc/conf/system_config.vim
 so ~/.zk_vimrc/conf/functions.vim
 so ~/.zk_vimrc/conf/mappings.vim
 so ~/.zk_vimrc/conf/autocmds.vim
 so ~/.zk_vimrc/conf/plugins_config.vim
 colorscheme gruvbox
' > ~/.vimrc

echo "Installed the light Vim for human configuration successfully! Enjoy :-)"
