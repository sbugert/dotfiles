Installation
============

    git clone http://github.com/sbugert/dotfiles.git ~/.dotfiles
    ln -s ~/.dotfiles/bashrc ~/.bashrc
    ln -s ~/.dotfiles/bash_profile ~/.bash_profile
    ln -s ~/.dotfiles/tmux.conf ~/.tmux.conf
    ln -s ~/.dotfiles/gitconfig ~/.gitconfig
    ln -s ~/.dotfiles/iterm2 ~/.iterm2
    source ~/.bashrc
    base16_default-dark


enable italics
==============

    infocmp xterm-256color > /tmp/xterm-256color.terminfo
    printf '\tsitm=\\E[3m, ritm=\\E[23m,\n' >> /tmp/xterm-256color.terminfo
    tic /tmp/xterm-256color.terminfo

Source: http://www.eddieantonio.ca/blog/2015/04/16/iterm-italics/

