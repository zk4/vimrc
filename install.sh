#!/bin/sh
set -e

brew cash install kitty

cd ~/.zk_vimrc

echo 'set runtimepath+=~/.zk_vimrc

source ~/.zk_vimrc/core/basic.vim
source ~/.zk_vimrc/core/filetypes.vim
source ~/.zk_vimrc/core/plugins_config.vim
source ~/.zk_vimrc/core/extended.vim

try
source ~/.zk_vimrc/my_configs.vim
catch
endtry' > ~/.vimrc

echo "Installed the Ultimate Vim for human configuration successfully! Enjoy :-)"
