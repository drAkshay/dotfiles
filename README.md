#This has been copied from https://github.com/michaeljsmalley/dotfiles for most part #

This repository includes all of my custom dotfiles. They should be cloned to your home directory so that the path is ~/dotfiles/. The included setup script creates symlinks from your home directory to the files which are located in ~/dotfiles/.

The setup script is smart enough to back up your existing dotfiles into a ~/dotfiles_old/ directory if you already have any dotfiles of the same name as the dotfile symlinks being created in your home directory.

So, to recap, the install script will:

Back up any existing dotfiles in your home directory to ~/dotfiles_old/
Create symlinks to the dotfiles in ~/dotfiles/ in your home directory


Installation

git clone https://github.com/drAkshay/dotfiles ~/dotfiles
cd ~/dotfiles
./makesymlinks.sh