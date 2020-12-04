
source ./bash/bashrc

#
# intro()  
#
function intro()
{
	echo "#" > $1 
	echo "# Created by Opal on `date`"  >> $1	
	echo "#" >> $1 
	echo "" >> $1 
	echo "" >> $1 
}

#
# vim_intro ( filename )
#
function vim_intro()
{
    echo '' >> $1
    echo '"' >> $1
    echo '" Created by Opal on' `date`  >> $1
    echo '"' >> $1
    echo '' >> $1
}


#
# heading_box ( title, filename )  
#
function heading_box()
{
	cLine="################################################################################"

	echo $cLine >> $2 
	echo "#" >> $2 
	echo "# $1" >> $2	
	echo "#" >> $2 
	echo $cLine >> $2 
	echo "" >> $2
	echo "" >> $2
	echo "" >> $2
}

# Create a symbolic link to this directory in your home directory
install_dir=`pwd`
ln -s $install_dir ~/opal

# Create backups of your current files if they exist
now=$(today unix)
if [ -f ~/.bashrc ]; then
	mv ~/.bashrc ~/.bashrc.${now} 
fi

if [ -f ~/.bash_profile ]; then
	mv ~/.bash_profile ~/.bash_profile.${now} 
fi

if [ -f ~/.vimrc ]; then
	mv ~/.vimrc ~/.vimrc.${now} 
fi


#
# Generate the new bash files in the user's home directory
#
intro ~/.bashrc 

echo "Are you new to UNIX or Linux (y/n)?"
read is_new

if [ $is_new == "y" ] || [ $is_new == "Y" ]; then
	echo 'export OPAL_NOOB=1' >> ~/.bashrc
else
	echo 'export OPAL_NOOB=0' >> ~/.bashrc
fi

echo '' >> ~/.bashrc
echo 'source ~/opal/opal.bash' >> ~/.bashrc
echo '' >> ~/.bashrc

heading_box 'VARIABLES' ~/.bashrc 
heading_box 'FUNCTIONS' ~/.bashrc
heading_box 'ALIASES'  ~/.bashrc
echo '# Look in ~/opal/bash/aliases-clocks.bash for a list of available clocks' >> ~/.bashrc
echo 'alias clocks="utc; eastern; paris; tokyo"' >> ~/.bashrc

heading_box 'MAIN' ~/.bashrc


echo 'clocks' >> ~/.bashrc
echo '' >> ~/.bashrc
echo '# Assumes your terminal has a dark background. Change to light if needed  ' >> ~/.bashrc
echo 'termbg dark' >> ~/.bashrc
echo 'set_prompt brief' >> ~/.bashrc
echo '' >> ~/.bashrc

intro ~/.bash_profile 

echo '' >> ~/.bash_profile
echo 'source ~/opal/bash/bash_profile' >> ~/.bash_profile
echo '' >> ~/.bash_profile
echo 'preamble' >> ~/.bash_profile
echo '' >> ~/.bash_profile
echo '' >> ~/.bash_profile

heading_box 'BASH PROFILE' ~/.bash_profile

intro ~/.gitconfig 

echo '' >> ~/.gitconfig
echo '[include]' >> ~/.gitconfig
echo '    path = ~/opal/git/config' >> ~/.gitconfig
echo '' >> ~/.gitconfig
echo '[commit]' >> ~/.gitconfig
echo '    template = ~/opal/git/commit-message' >> ~/.gitconfig
echo '' >> ~/.gitconfig






vim_intro ~/.vimrc

echo ':source ~/opal/vimrc_files/vimrc' >> ~/.vimrc
echo ':source ~/opal/vimrc_files/vimrc_html' >> ~/.vimrc
echo '' >> ~/.vimrc
echo '"' >> ~/.vimrc
echo '" Put your vim settings below here' >> ~/.vimrc
echo '"' >> ~/.vimrc
echo '' >> ~/.vimrc
echo '' >> ~/.vimrc


