# Opal

A command line framework for Bash users


Each developer creates their own dotfiles. There's often a lot of copying
between developers, and even between multiple configs for a specific developer.
Opal is a framework that fixes this, by providing a cohesive set of files to
create a solid foundation. This foundation can be easily re-used across users
and machines. Opal is designed to be easily extended, allowing you to add your
custom configuration on top of it. Put simply, Opal is a collection of
unix/linux dotfiles and utilities, reusable across machines and users, for
people who love the command line


## Getting Started

1. Download the opal and extract the tarball.

    `$ curl --location --output opal.zip https://github.com/andrewwoods/opal/archive/master.zip`

    `$ unzip opal.zip`

2. Change into the new directory

    `$ cd opal-master`

3. Run the install script

    `$ ./install.bash`

This creates a symbolic link in your home directory, to the directory where you
ran the install script. Also, opal created a some dot files in your home
directory - notably the .bashrc, .bash_profile, and .vimrc - to allow for your
own customizations, while using opal resources. if you already had those files,
don't panic - your files were backed up.


## What's In Here

This project is about more than just making vim easier to use. It's about
making your life on the command line a little easier. This is done thru a
variety of bash functions an eventually shell scripts. Here's a list of what's
included

### Project files

* [Change Log](CHANGELOG.md)
* [License](LICENSE.txt) 


## Present

Present is a command line(CLI) tool written in Bash :)

	$ present your_dir_name

The 'your\_dir\_name' is a directory were you'll want to keep all the files
related to this individual presentation. It needs a file called
*present-lib.bash*.  At the top of present-lib.bash, there needs to be an array
called Slides.  Each index in the Slides array, is the name of a bash function
that you write.  This is where your magic happens.



## Vim Files

There are multiple vimrc files, one per type of programming style - Wordpress,
Drupal, CodeIgniter, Zend, and Ruby. If there are others that interest you,
feel free to create it and I'll add it.

To use the WordPress vim file, use the wpvi alias when opening a file

	$ wpvi functions.php

**The HTML vim file that is load by all the others vim files.**

It helps you write your markup consistently. Vim uses abbreviations to make
reduce your typing. Each HTML tag has an associated abbreviation. It's not just
HTML though. PHP code and phpdoc blocks.

To create a piece of code or markeup like '&lt;title&gt;&lt;/title&gt;', just
type 't_title'.

In short, the formula is html tags is 't_' + tagname.
html entities have the formula 'e_' + name.

Here are a few examples

	e_copy
	e_pound
	e_currency
	e_ellipsis

php control structures have the formula 'c_' + name.

	c_if       # will create an if block
	c_ifelse   # will create if/else blocks
	c_while    # will create a while loop
	c_function # will create a function

phpdoc codes have the formula 'x_' + name.

	x_package  # will create a package phpdoc block comment
	x_function # will create a function phpdoc block comment
	x_method   # will create a class method phpdoc block comment

Take a look at the vimrc files to see everything it can do.


