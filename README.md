Installing on another machine
=============================
    git clone http://github.com/sbugert/dotvim.git ~/.vim
    ln -s ~/.vim/vimrc ~/.vimrc
    ln -s ~/.vim/gvimrc ~/.gvimrc
    git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    vim +PluginInstall +qall
    cd ~/.vim/bundle/YouCompleteMe
    ./install.sh --clang-completer --tern-completer

Upgrading all bundled plugins
=============================
`vim +PluginInstall +qall` or `:PluginInstall` inside vim
