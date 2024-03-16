
# Bash

## Contents

* Aliases
* Functions
	- [Utility Functions](bash-util.md)
	- [Developer Functions](bash-developer-functions.md)
* [Noob](bash-noob.md)

## Aliases

An alias is a keyword that is substituted for a command. Usually, an alias is
used for a longer, complicated, or hard to remember command.

### Clocks

There are many aliases that display the current time from around the world.  In
most cases, it's name of a main city - paris, london, vancouver, tokyo. There
are some that have names for the time zone they represent - utc, gmt, eastern,
central, mountain, and pacific.

```
$ utc
Mon Mar 25 21:17:13 UTC 2019 -- Universal Time
```

In addition to these, I've added some aliases that group some clocks by the continents.

```
$ na_clocks
Mon Mar 25 17:17:08 EDT 2019 -- US Eastern
Mon Mar 25 16:17:08 CDT 2019 -- US Central
Mon Mar 25 15:17:08 MDT 2019 -- US Mountain
Mon Mar 25 14:17:08 MST 2019 -- US Arizona
Mon Mar 25 14:17:08 PDT 2019 -- US Pacific

Mon Mar 25 17:17:08 EDT 2019 -- Canada, Toronto
Mon Mar 25 15:17:08 CST 2019 -- Mexico, Mexico City
Mon Mar 25 16:17:08 CDT 2019 -- Canada, Winnipeg
Mon Mar 25 14:17:08 PDT 2019 -- Canada, Vancouver
```




## Bash Functions


**CAL3**: a 3 month calendar display - previous month, current month, and next
month

	$ opal:cal3

**DEFINE**: Retrieve the definition of a word

	$ opal:define ginger

**LSKEYS**: Display a list of your SSH keys

	$ opal:lskeys

**MACH**: display information about the current host.

	$ opal:mach

**MKCD**: Create a directory and go into it. accepts a single directory name.

	$ opal:mkcd newdirectory

**NCAL3**: a 3 month calendar displayed vertically - previous month, current
month, and next month

	$ opal:ncal3

**NUMSEG**: display part of a file, with line numbers prepended

display line 50, the 10 lines before/after it, with line numbers

	$ opal:numseg /etc/apache2/httpd.conf 50

display lines 32 through 48 with line numbers

	$ opal:numseg /etc/apache2/httpd.conf 32 48

**PARSE_GIT_BRANCH**: detects when you're in a git project and extracts the
name of the active branch. Used by the set_prompt() function

	$ opal:parse_git_branch

**PREAMBLE**: Display a login message about who and where you are.

	$ opal:preamble

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

	$ opal:show_dotfiles true
	$ opal:show_dotfiles false


**TODAY**: display today's date in a number of formats. There are a few formats
to start of with. specify the type and optionally the format.

	# Default       2012 Mar 31 Sat 13:07
	# custom        2012 Mar 31 13:07 -0700
	# custom date   2012 Mar 31 Sat
	# iso           2012-03-31T13:07:59-0700
	# iso date      2012-03-31
	# us            03/31/2012 13:07 PM
	# us text       Mar 31, 2012 13:07 PM
	# unix          1333224479
	# world         31/03/2012 13:07:59
	# world text    31 Mar 2012 13:07:59


	$ opal:today iso-timestamp
	2012-03-31T13:07:59-0400

	$ opal:today world text
	31 Mar 2012 13:07:59

**TOUCHX**: Create an empty file and make it executable

	$ opal:touchx filename.txt
	$ opal:touchx info.php phpinfo
	$ opal:touchx robots.txt

**TRUNCATE**: Remove the *contents* of a file without deleting it.
'empty' is an alias

	$ opal:truncate myfile.txt

	# You can also use
	$ opal:empty myfile.txt
