#!/bin/bash
# some code lifted from https://github.com/michaeljsmalley/dotfiles/blob/master/makesymlinks.sh
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
files="bash_profile tmux.conf gitconfig bashrc"    # list of files/folders to symlink in homedir
emacs="emacs.d" # emacs dot file 
#files="bashrc vimrc vim zshrc oh-my-zsh private scrotwm.conf Xresources"

##########

# create dotfiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p $olddir
echo "done"

# change to the dotfiles directory
echo -n "Changing to the $dir directory ..."
cd $dir
echo "done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/.$file ~/dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done

# see the different way i use the dir. structure for emacs. the emacs.d file i have is stored under ~/.emacs.d/init.el
for efile in $emacs; do
    echo "Moving any existing dotfiles from ~/.emacs.d to $olddir"
    mv ~/.$efile/init.el ~/dotfiles_old/.$efile
    echo "Creating symlink to $efile in home directory."
    ln -s $dir/$efile ~/.$efile/init.el
done