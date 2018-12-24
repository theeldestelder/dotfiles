#!/bin/bash

NVIM_CONFIG_DIR=$HOME/.config/nvim
SCRIPT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" > /dev/null && pwd )"

mkdir -p $NVIM_CONFIG_DIR

echo Linking Neovim settings into $NVIM_CONFIG_DIR...
ln -sf $SCRIPT_PATH/init.vim $NVIM_CONFIG_DIR/init.vim 

echo ""
echo Done!
