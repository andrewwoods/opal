# opal

a unix bootstrap of dotfiles with some useful additional utilities

There are many different ways you can config a unix or linux system. There are 
tons of dotfiles spread acoross the internet. But there isn't a cohesive set of 
files that are re-usable across users, across machines. This project seeks to 
provide a reusable set of files. 


## GETTING STARTED

1. Download the opal and extract the tarball into your home directory.
2. Rename the directory directory opal

These scripts are normally dot files that are located in your home directory.
The files in this directory don't use dots at the beginning of the file
for better user experience. They're here to give you a solid 
foundation for when you encounter a new environment, and to assist you in 
writing better code faster. 

One way to get started is to create symbolic links from your home dir to files 
in this project like so (assuming this directory is named ~/opal) :

	$ cd ~
	$ ln -s opal/vimrc .vimrc 
	$ ln -s opal/bashrc .bashrc
	$ ln -s opal/bash_profile .bash_profile

While that will work, it's not a good long term strategy. When you get an 
update from this project, you'll lose your changes. A better way to use is 
create a file in your home directory, and have it read the contents of the 
corresponding file in this project. This will allow you to receive all the 
updates of the project while keeping any customizations you make. Here's an 
example using the .vimrc file

	$ cd ~
	$ vi .vimrc

### Filename: ~/.vimrc 
```vim

:source ~/opal/vimrc

"
" Put your vim settings below here
"

```


This is how to do it using BASH.

### Filename: ~/.bashrc
```vim
source ~/opal/bashrc

#
# Put your Bash settings, variables, and functions below here.
#

```

### Filename: ~/.bash_profile
```vim

source ~/opal/bash_profile

#
# Put your Bash settings, variables, and functions below here.
#

```

# WHAT'S IN HERE

This project is about more than just making vim easier to use. It's about 
making your life on the command line a little easier. This is done thru a 
variety of bash functions an eventually shell scripts. Here's a list of what's 
included


## Bash Functions

PUNCH: keep track of when you start and stop working on things.

updates a file called timesheet.txt in your home directory. It takes one 
argument whos value can be 'in' or 'out'

	$ punch in
	$ punch out


MKCD: Create a directory and go into it. accepts a single directory name. 

	$ mkcd newdirectory

TODAY: display today's date in a number of formats. There are a few formats 
to start of with. specify the type and optionally the format.  

```bash
# Default   Sat 2012 Mar 31 1:07 PM
# iso       2012 03 31 13:07:59
# iso text  2012-Mar-31 13:07:59
# uk        31/03/2012 13:07:59
# uk text   31 Mar 2012 13:07:59
# us        03/31/2012 1:07 PM
# uk text   Mar 31, 2012 1:07 PM
# unix      1333224479

$ today iso
2012 03 31 13:07:59

$ today uk text
31 Mar 2012 13:07:59
```

TOUCHX: Create an empty file and make it executable 

	$ touchx filename.txt

MACH: display information about the current host.

	$ mach

SHOW: display information about different types of info in the shell. the 
output for each of the arguments depends on your system. 

```bash

$ show
	
# arrays -  display known arrays 
# names - display function names only
# defs - display functions names and their definitions
# readonly - display all the readonly variables
# export - display all exported variables
# integers - display all integers

$ show names
```

PREAMBLE: Display a login message about who and where you are.

	$ preamble


