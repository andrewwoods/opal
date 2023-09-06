source bashrc.bash
source "bash/core.bash"

#
# intro()
#
function intro() {
    echo "#" >$1
    echo "# Created by Opal on $(date)" >>$1
    echo "#" >>$1
    echo "" >>$1
    echo "" >>$1
}

#
# vim_intro ( filename )
#
function vim_intro() {
    echo '' >>$1
    echo '"' >>$1
    echo '" Created by Opal on' $(date) >>$1
    echo '"' >>$1
    echo '' >>$1
}

#
# heading_box ( title, filename )
#
function heading_box() {
    cLine="################################################################################"

    echo $cLine >>$2
    echo "#" >>$2
    echo "# $1" >>$2
    echo "#" >>$2
    echo $cLine >>$2
    echo "" >>$2
    echo "" >>$2
    echo "" >>$2
}

# Create a symbolic link to this directory in your home directory
install_dir=$(pwd)
ln -s $install_dir ~/opal

# Create backups of your current files if they exist
now=$(today unix)
if [ -f ~/.bashrc ]; then
    mv ~/.bashrc ~/.bashrc.${now}
fi

if [ -f ~/.bash_profile.bash ]; then
    mv ~/.bash_profile.bash ~/.bash_profile.bash.${now}
fi

if [ -f ~/.vimrc ]; then
    mv ~/.vimrc ~/.vimrc.${now}
fi

#
# Generate the new bash files in the user's home directory
#
opal:message "Generating .bashrc"
intro ~/.bashrc

heading_box 'INCLUDES' ~/.bashrc
echo 'source ~/opal/opal.bash' >>~/.bashrc
echo '# @TODO: Add other bash files below here ' >>~/.bashrc
echo '' >>~/.bashrc

heading_box 'VARIABLES' ~/.bashrc
heading_box 'FUNCTIONS' ~/.bashrc
heading_box 'ALIASES'  ~/.bashrc
echo '# Look in ~/opal/bash/aliases-clocks.bash for a list of available clocks' >>~/.bashrc
echo 'alias clocks="utc; eastern; paris; tokyo"' >>~/.bashrc

heading_box 'MAIN' ~/.bashrc

echo 'clocks' >>~/.bashrc
echo '' >>~/.bashrc
echo '# Assumes your terminal has a dark background. Change to light if needed  ' >>~/.bashrc
echo 'termbg dark' >>~/.bashrc
echo 'opal:ps1_default_dark' >>~/.bashrc
echo 'opal:ps2_default_dark' >>~/.bashrc
echo 'opal:ps3_default' >>~/.bashrc
echo 'opal:ps4_default' >>~/.bashrc
echo '' >>~/.bashrc

opal:message "Generating .bash_profile"
intro ~/.bash_profile.bash

echo '' >>~/.bash_profile.bash
echo 'source ~/opal/bash/bash_profile.bash' >>~/.bash_profile.bash
echo '' >>~/.bash_profile.bash
echo 'preamble' >>~/.bash_profile.bash
echo '' >>~/.bash_profile.bash
echo '' >>~/.bash_profile.bash

heading_box 'BASH PROFILE' ~/.bash_profile.bash

opal:message "Generating .gitconfig"
intro ~/.gitconfig

echo '' >>~/.gitconfig
echo '[include]' >>~/.gitconfig
echo '    path = ~/opal/git/config' >>~/.gitconfig
echo '' >>~/.gitconfig
echo '[commit]' >>~/.gitconfig
echo '    template = ~/opal/git/commit-message' >>~/.gitconfig
echo '' >>~/.gitconfig

opal:message "Generating .vimrc"
vim_intro ~/.vimrc

echo ':source ~/opal/vimrc_files/vimrc' >>~/.vimrc
echo '' >>~/.vimrc
echo '"' >>~/.vimrc
echo '" Put your vim settings below here' >>~/.vimrc
echo '"' >>~/.vimrc
echo '' >>~/.vimrc
echo '' >>~/.vimrc
