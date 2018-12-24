#!/bin/bash

NVIM_CONFIG_DIR=$HOME/.config/nvim

mkdir -p $NVIM_CONFIG_DIR

# install dein and remove intermediate file
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh $NVIM_CONFIG_DIR
rm installer.sh
