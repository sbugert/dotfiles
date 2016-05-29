Installing on another machine
=============================
    git clone http://github.com/sbugert/dotvim.git ~/.vim
    ln -s ~/.vim/vimrc ~/.vimrc
    vim +PlugInstall +qall

Upgrading all bundled plugins
=============================
`vim +PlugUpgrade +PlugUpdate +qall` or `:PluginInstall` and `PlugUpgrade` inside vim
