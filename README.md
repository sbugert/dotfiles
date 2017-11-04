Usage
============

  `make` to list possible commands
  `make install` to link dotfiles
  `make installmac` to link dotfiles, decrypt private files and install iTerm2 config

enable italics
==============

    infocmp xterm-256color > /tmp/xterm-256color.terminfo
    printf '\tsitm=\\E[3m, ritm=\\E[23m,\n' >> /tmp/xterm-256color.terminfo
    tic /tmp/xterm-256color.terminfo

Source: http://www.eddieantonio.ca/blog/2015/04/16/iterm-italics/

