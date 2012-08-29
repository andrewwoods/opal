
source ./bashrc


# Remove the symbolic link in their home directory
rm ~/opal

# Re-Create a symbolic link to this directory in the user's home directory
install_dir=`pwd`
ln -s $install_dir ~/opal


