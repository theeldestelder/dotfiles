#!/bin/bash

NVIM_CONFIG_DIR=$HOME/.config/nvim

mkdir -p NVIM_CONFIG_DIR

ln -sv init.vim $NVIM_CONFIG_DIR/init.vim 
