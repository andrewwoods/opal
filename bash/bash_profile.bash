#
# Opal Bash Profile
#

export BASH_SILENCE_DEPRECATION_WARNING=1

#
# Update the $PATH based on common directory conventions
#
if [ -d $HOME/opal/bin ]; then
    PATH="$PATH:$HOME/opal/bin"
fi

if [ -d $HOME/.local/bin ]; then
    PATH="$PATH:$HOME/.local/bin"
fi

