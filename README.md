Installing on another machine
=============================
    git clone http://github.com/sbugert/dotvim.git ~/.vim
    ln -s ~/.vim/vimrc ~/.vimrc
    ln -s ~/.vim/gvimrc ~/.gvimrc
    git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    vim +PluginInstall +qall

Change `call <SID>X("NonText", "438ec3", "b7dce8", "")` to `call <SID>X("NonText", "438ec3", "ffffff", "")` in bundle/summerfruit256.vim/colors/summerfruit256.vim until I find a better way ಠ_ಠ

Upgrading all bundled plugins
=============================
`vim +PluginInstall +qall` or `:PluginInstall` inside vim
