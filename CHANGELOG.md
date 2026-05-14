
# Change Log

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## 3.0.0 - 2026-05-12

Version 3.0 is a Major rewrite. A Bash scripting layer was added using the
`opal:` namespace, with some improved configuration for Neovim and Vim.
Some updates were made to the data directory content.

### Added

* Add a Bash scripting layer to help with the following
    - Add logging functions for standard error levels
    - Add string functions for easier string manipulation
    - Add file system functions to simplify existence and permissions checks
    - Add prompt functions to give control over your Bash prompt
    - Add functions to improve your user experience
    - Add developer related functions
    - Add XDG support for your config files
    - Add ps3-example.bash and ps4-example.bash for testing your prompts
    - Add various aliases for displaying the current time in differnt timezones

* Added quick config setup for Neovim and Vim without plugins
    - Common settings for a usable UI
    - Useful keymaps for a better experience

* Added Git Config help
* Added the Opal Dark and Opal Light theme files for iTerm2 users

### Updated

* Updated the PHP and WordPress versions history logs.
* Updated the HTTP Status Codes list
* Updated the RFCs list
* Updated the ISO country codes list

### Removed

* Removed the present function
* Removed the punch function for logging your task time
* Removed some dev-related Vim functions

## 2.3.0 - 2022-04-24

### Added

TODO Review the git log to complete this section

### Updated

TODO Review the git log to complete this section


## 2.2.0 - 2020-12-06

### Added

* Add Git commit message template

### Updated

* Fix some pathing issues related to file organiztion to prevent errors
* Improve Git colors for dark theme
* Improve the default .bashrc file created by install script
* updated time related aliases


## 2.0.0 - 2017-01-02

### Added

- CHANGELOG.md
- New Vimrc files
  * bash
  * css
  * ghmd
  * js
  * laravel
  * php
  * python
  * scribe
  * symfony
- Add Web Development Checklist to Help directory
- Add Data files
  * canada.txt
  * http-methods.txt
  * php/README.txt
  * php/php-version-history.txt
  * php/wp-version-history.txt
  * powers-of-two.txt
  * rfcs.txt
  * temperature.txt
  * time.txt
  * weight.txt
- Add Vim Function Files
  * edit.vim
  * search.vim
  * spacehi.vim



### Updated

- README.md
- Moved vimrc files to vimrc_files/ directory
- Updated Help Files
  * snippets.txt
  * vim-notes.txt
  * vim-reference.txt
- bashrc
- Updated Help Files
  * snippets.txt
  * vim-notes.txt
  * vim-reference.txt
- install.bash
- timecalc.php
- typer: a script to give the appearance of typing strings of text


## 1.1.0 - 2014-02-01

### Updated

- Improved documenation in README.md
- bashrc
  * add ability to dispaly git branch in prompt
  * add cal3 and ncal3 to display previous, current, and next months
- help/vim-reference.txt
  * Add notes on Vim folding commands
- install.bash
- vimrc
- vimrc_codeigniter
  * Add fold marker settings
  * Add abbreviations to wrtie code
  * Add function to check PHP syntax upon saving .php files
- vimrc_wordpress
  * Add fold marker settings
  * Add abbreviations to wrtie code
  * Add function to check PHP syntax upon saving .php files


## 1.0.0 - 2013-08-29

First version of Opal.

### Added

- README.md
- LICENSE.txt
- project specific vimrc files
- bashrc and bash_profile
- timecalc.php
- typer
- Data Files
  * http-status-codes.txt
  * iso-country-codes.txt
  * us.txt
- Help Files
  * command-line-osx.txt
  * faq.txt
  * snippets.txt
  * vim-notes.txt
  * vim-reference.txt

