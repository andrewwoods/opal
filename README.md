# opal

unix/linux dotfiles and utilities, reusable across machines/users, for people who love the command line

There are many different ways you can config a unix or linux system. There are 
tons of dotfiles spread acoross the internet. But there isn't a cohesive set of 
files that are re-usable across users, across machines. This project seeks to 
provide a reusable set of files. 


## GETTING STARTED

1. Download the opal and extract the tarball.
2. cd into the new directory
3. Run the install script

    $ ./install.bash 

This creates a symbolic link in your home directory, to the directory where you ran the install script. Also, opal created a some dot files in your home directory - notably the .bashrc, .bash_profile, and .vimrc - to allow for your own customizations, while using opal resources. if you already had those files, don't panic - your files were backed up.


## WHAT'S IN HERE

This project is about more than just making vim easier to use. It's about 
making your life on the command line a little easier. This is done thru a 
variety of bash functions an eventually shell scripts. Here's a list of what's 
included


## Bash Functions



CAL3: a 3 month calendar display - previous month, current month, and next month

	$ cal3


DEFINE: Retrieve the definition of a word

	$ define ginger


LSKEYS: Display a list of your SSH keys

	$ lskeys


MACH: display information about the current host.

	$ mach

MKCD: Create a directory and go into it. accepts a single directory name. 

	$ mkcd newdirectory

NCAL3: a 3 month calendar displayed vertically - previous month, current month, and next month

	$ ncal3


NUMSEG: display part of a file, with line numbers prepended

display line 50, the 10 lines before/after it, with line numbers  

	$ numseg /etc/apache2/httpd.conf 50

display lines 32 through 48 with line numbers  

	$ numseg /etc/apache2/httpd.conf 32 48


PARSE_GIT_BRANCH: detects when you're in a git project and extracts the name of the active branch. Used by the set_prompt() function 

	$ parse_git_branch


PREAMBLE: Display a login message about who and where you are.

	$ preamble


PROMPT: A great way to display a line to text. Like echo, but types out the 
characters one at a time, as if you typed it 


PUNCH: keep track of when you start and stop working on things by writing to the timesheet.txt file. the included timecalc.php scripts parses the timesheet.txt file. Great for freelancers who track their time, and use tools like GetHarvest or Free Agent.

It's first argument can be 'in', 'out', 'note', or 'switch'
The second argument is only *required* for 'note', but it's useful for keeping track of what you work on

	$ punch in  
	$ punch in "type a brief message here" 
	$ punch out 
	$ punch out "type a brief message here" 
	$ punch note "type a brief message here" 
	$ punch switch "type a brief message here"

For best results, add a note when you punch in. Include things like an issue number, client name, or project name and a few words about the task. I'd love to know what works for you.

SET_PROMPT: Allows you to easily change the values displayed in your prompt. Uses the parse_git_branch() function.   

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

SHOW_DOTFILES: enable/disable display of hidden dotfiles in OS X finder

	$ show_dotfiles true
	$ show_dotfiles false



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
	$ touchx info.php phpinfo 
	$ touchx robots.txt 

TRUNCATE: Remove the *contents* of a file without deleting it. 
'Empty' is an alias

	$ truncate myfile.txt

	# You can also use
	$ empty myfile.txt

## Present

Present is a command line(CLI) tool written in Bash :)

	$ present your_dir_name

The 'your_dir_name' is a directory were you'll want to keep all the files
related to this individual presentation. It needs a file called *present-lib.bash*.
At the top of present-lib.bash, there needs to be an array called Slides.
Each index in the Slides array, is the name of a bash function that you write.
This is where your magic happens.



## Vim Files

There are multiple vimrc files, one per type of programming style - Wordpress, 
Drupal, CodeIgniter, Zend, and Ruby. If there are others that interest you, feel free to 
create it and I'll add it. 

To use the WordPress vim file, use the wpvi alias when opening a file

$ wpvi functions.php

**The HTML vim file that is load by all the others vim files.** 

It helps you write your markup consistently. Vim uses abbreviations to make 
reduce your typing. Each HTML tag has an associated abbreviation. It's not just 
HTML though. PHP code and phpdoc blocks. 

To create a piece of code or markeup like '<title></title>', just type 't_title'. 

In short, the formula is html tags is 't_' + tagname. 
html entities have the formula 'e_' + name. 

Here are a few examples
	e_copy 
	e_pound 
	e_currency 
	e_ellipsis

php control structures have the formula 'c_' + name. 
	c_if will create an if block
	c_ifelse will create if/else blocks
	c_while will create a while loop
	c_function will create a function

phpdoc codes have the formula 'x_' + name. 
	x_package will create a package phpdoc block comment
	x_function will create a function phpdoc block comment
	x_method will create a class method phpdoc block comment

Take a look at the vimrc files to see everything it can do.  


