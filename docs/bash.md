
# Bash

## Contents

* Functions


## Bash Functions


**CAL3**: a 3 month calendar display - previous month, current month, and next
month

	$ cal3

**DEFINE**: Retrieve the definition of a word

	$ define ginger

**LSKEYS**: Display a list of your SSH keys

	$ lskeys

**MACH**: display information about the current host.

	$ mach

**MKCD**: Create a directory and go into it. accepts a single directory name.

	$ mkcd newdirectory

**NCAL3**: a 3 month calendar displayed vertically - previous month, current
month, and next month

	$ ncal3

**NUMSEG**: display part of a file, with line numbers prepended

display line 50, the 10 lines before/after it, with line numbers

	$ numseg /etc/apache2/httpd.conf 50

display lines 32 through 48 with line numbers

	$ numseg /etc/apache2/httpd.conf 32 48

**PARSE_GIT_BRANCH**: detects when you're in a git project and extracts the
name of the active branch. Used by the set_prompt() function

	$ parse_git_branch

**PREAMBLE**: Display a login message about who and where you are.

	$ preamble

**PROMPT**: A great way to display a line to text. Like echo, but types out the
characters one at a time, as if you typed it


**PUNCH**: keep track of when you start and stop working on things by writing
to the timesheet.txt file. the included timecalc.php scripts parses the
timesheet.txt file. Great for freelancers who track their time, and use tools
like GetHarvest or Free Agent.

It's first argument can be 'in', 'out', 'note', or 'switch'.  The second
argument is only *required* for 'note', but it's useful for keeping track of
what you work on

	$ punch in
	$ punch in "type a brief message here"
	$ punch out
	$ punch out "type a brief message here"
	$ punch note "type a brief message here"
	$ punch switch "type a brief message here"

For best results, add a note when you punch in. Include things like an issue
number, client name, or project name and a few words about the task. I'd love
to know what works for you.

**SET_PROMPT**: Allows you to easily change the values displayed in your
prompt. Uses the parse_git_branch() function.

**SHOW**: display information about different types of info in the shell. the
output for each of the arguments depends on your system.


	$ show

	arrays -  display known arrays
	names - display function names only
	defs - display functions names and their definitions
	readonly - display all the readonly variables
	export - display all exported variables
	integers - display all integers

	$ show names


**SHOW_DOTFILES**: enable/disable display of hidden dotfiles in OS X finder

	$ show_dotfiles true
	$ show_dotfiles false


**TODAY**: display today's date in a number of formats. There are a few formats
to start of with. specify the type and optionally the format.

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

**TOUCHX**: Create an empty file and make it executable

	$ touchx filename.txt
	$ touchx info.php phpinfo
	$ touchx robots.txt

**TRUNCATE**: Remove the *contents* of a file without deleting it.
'Empty' is an alias

	$ truncate myfile.txt

	# You can also use
	$ empty myfile.txt
