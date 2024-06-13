# Dotfiles

These are my dotfiles.

I use zsh as my shell and NeoVim as my text editor.

### Contents
- `init.vim` - Neovim settings
- `install.sh` - installer script to create appropriate symlinks
- `setup.sh` - installs Dein for Neovim

## Usage
Clone the repository:

    git clone git@github.com:theeldestelder/dotfiles.git

Change into the repository directory:

    cd dotfiles

Run the install script:

    ./install.sh

## Symlinks you're gonna need

You're gonna need to make sure these directories exist too.

- custom zsh theme
```
ln -s ~/dotfiles/ozzy.zsh-theme ~/.oh-my-zsh/custom/themes/ozzy.zsh-theme
```

- .zshrc
```
ln -s ~/dotfiles/.zshrc ~/.zshrc
```

- init.vim
```
ln -s ~/dotfiles/.init.vim ~/.config/nvim/init.vim
```
