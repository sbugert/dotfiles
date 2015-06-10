Installing on another machine
=============================
    git clone http://github.com/sbugert/dotvim.git ~/.vim
    ln -s ~/.vim/vimrc ~/.vimrc
    ln -s ~/.vim/gvimrc ~/.gvimrc
    mkdir ~/.vim/.vim-tmp
    git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    vim +PluginInstall +qall
    cd ~/.vim/bundle/YouCompleteMe
    ./install.sh
    cd ~/.vim/bundle/tern_for_vim
    npm install

Upgrading all bundled plugins
=============================
`vim +PluginInstall +qall` or `:PluginInstall` inside vim
