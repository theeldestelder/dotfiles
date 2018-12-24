#!/bin/bash

CURRENT_DIR=$(pwd)

NVIM_CONFIG_DIR=$HOME/.config/nvim
SCRIPT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" > /dev/null && pwd )"

CONFIG_DIR=$HOME/.config

# ensure NVIM_CONFIG_DIR path exists
mkdir -p $NVIM_CONFIG_DIR

cd $HOME
# install dein
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh $NVIM_CONFIG_DIR
rm $HOME/installer.sh

cd $CURRENT_DIR

echo Linking Neovim settings into $NVIM_CONFIG_DIR...
ln -sf $SCRIPT_PATH/init.vim $NVIM_CONFIG_DIR/init.vim 

echo ""
echo Done!
