#
# .bashrc - this file runs when any news bash shell is created
#
################################################################################


if [[ $OPAL_NOOB -eq '1' ]]; then
    echo "Loading Noob Settings"
    source $OPAL_DIR/bash/noob.bash
fi

