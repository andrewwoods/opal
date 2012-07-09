
#
# For people who are learning
#

# For convenience 
alias ll='ls -l'
alias la='ls -a'
alias lc='ls --color'
alias quit='exit'


# just to be safe
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

set -o noclobber       # prevent overwriting files with cat
set -o ignoreeof       # stops ctrl+d from logging me out


# For DOS/Windows users
alias chdir='echo "you should use the \"pwd\" command"; pwd'
alias cls='echo "you should use the \"clear\" command"; clear'
alias copy='echo "you should use the \"cp\" command"; cp -piv'
alias del='echo "you should use the \"rm\" command"; rm -iv'
alias deltree='echo "you should use the \"rm\" command"; rm -R'
alias dir='echo "you should use the \"ls\" command"; ls -l'
alias erase='echo "you should use the \"rm\" command"; rm -iv'
alias help='echo "you should use the \"man\" command"; man'
alias md='echo "you should use the \"mkdir\" command"; mkdir'
alias move='echo "you should use the \"mv\" command"; mv -iv'
alias path='echo $PATH'
alias rd='echo "you should use the \"rmdir\" command"; rmdir' 
alias rename='echo "you should use the \"mv\" command"; mv -iv'
alias rmdir='echo "you should use the \"rm\" command"; rm -R'
alias time='echo "you should use the \"date\" command"; date'
alias tree='echo "you should use the \"ls\" command"; ls -R'
alias xcopy='echo "you should use the \"cp\" command"; cp -R'

