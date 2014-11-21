Installing on another machine
=============================
    git clone http://github.com/sbugert/dotvim.git ~/.vim
    ln -s ~/.vim/vimrc ~/.vimrc
    ln -s ~/.vim/gvimrc ~/.gvimrc
    mkdir ~/.vim/.vim-tmp
    git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    vim +PluginInstall +qall

Change `call <SID>X("NonText", "438ec3", "b7dce8", "")` to `call <SID>X("NonText", "438ec3", "ffffff", "")` in bundle/summerfruit256.vim/colors/summerfruit256.vim until I find a better way ಠ_ಠ

Or use this ridiculously long command (working on OSX and Linux):

    sed -i -e 's|call <SID>X("NonText", "438ec3", "b7dce8", "")|call <SID>X("NonText", "438ec3", "ffffff", "")|g' ~/.vim/bundle/summerfruit256.vim/colors/summerfruit256.vim && rm ~/.vim/bundle/summerfruit256.vim/colors/summerfruit256.vim-e

Upgrading all bundled plugins
=============================
`vim +PluginInstall +qall` or `:PluginInstall` inside vim
