mkdir -p $HOME/.config/nvim/bundle
git clone https://github.com/VundleVim/Vundle.vim $HOME/.config/nvim/bundle/Vundle.vim
nvim +PluginInstall +qall
