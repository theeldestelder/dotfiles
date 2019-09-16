#!/bin/zsh

# get parent directory of this script
SCRIPT_PATH=${0:a}

NVIM_CONFIG_DIR=$HOME/.config/nvim
VIM_PLUG_DIR=$HOME/.local/share/nvim

# init.vim stuff
mkdir -p $NVIM_CONFIG_DIR

echo Linking Neovim settings into $NVIM_CONFIG_DIR...
ln -s $SCRIPT_PATH/init.vim $NVIM_CONFIG_DIR/init.vim

# vim-plug stuff
mkdir -p $VIM_PLUG_DIR

# location of plugins
mkdir -p $VIM_PLUG_DIR/plugged


echo Linking .zshrc into $HOME...
ln -s $SCRIPT_PATH/.zshrc $HOME/.zshrc

echo Linking .tmux.conf into $HOME...
ln -s $SCRIPT_PATH/tmux.conf $HOME/.tmux.conf



echo ""
echo Done!
