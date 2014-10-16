#!/bin/zsh

dot=(
  agignore
  fonts
  gemrc
  gitconfig
  gnuplot
  inputrc
  irbrc
  jshintrc
  latexmkrc
  mailcap
  Makefile
  mutt
  procmailrc
  pymolrc
  rdebugrc
  ssh
  tmux.conf
  vim
  vimrc
  vmd
  vmdrc
  Xmodmap
  zlogin
  zlogout
  zprofile
  zshenv
  zshrc
)

normal=(
  bin
)

cd $HOME
mkdir .undodir
for i in ${dot[@]};do
  ln -s .dotfiles/$i ".${i}"
done

for i in ${normal[@]};do
  ln -s .dotfiles/$i
done

cd .dotfiles/tmp
touch namaz
touch weather
touch dirs

cd ../data
tic xterm-tmux
mkdir ~/.config/fontconfig/conf.d/
cp 10-powerline-symbols.conf ~/.config/fontconfig/conf.d
cd ../mutt
touch aliases
