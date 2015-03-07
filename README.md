Installing on another machine
=============================
    git clone http://github.com/sbugert/dotvim.git ~/.vim
    ln -s ~/.vim/vimrc ~/.vimrc
    ln -s ~/.vim/gvimrc ~/.gvimrc
    mkdir ~/.vim/.vim-tmp
    git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    vim +PluginInstall +qall

Upgrading all bundled plugins
=============================
`vim +PluginInstall +qall` or `:PluginInstall` inside vim
