
# Vim


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

