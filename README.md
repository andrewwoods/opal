# Opal

A command line framework for Bash users

Each person creates their own dotfiles. There's often a lot of copying between
them, and even between multiple configs for a specific person. Scripting in
Bash can be challenging. Opal is a framework that fixes these two issues, by
providing a cohesive set of files to create a strong, common foundation.

This foundation is easily re-used across users and machines. Opal is designed
to be easily extended, allowing you to add your custom configuration on top of
it. Opal also provides a Bash scripting layer.

__Put simply__, Opal is a collection of unix/linux dotfiles and utilities,
reusable across machines and users, for people who love the command line.

## Current Version

Version **3.0.0** is the latest version.

## Getting Started

1. Download the opal code and extract the tarball.

    You can download the [Opal](https://github.com/andrewwoods/opal) Zip file
    from Github with your browser, or run the following commands in your terminal

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

There's a lot in this new version of Opal. In fact, I created the [Opal Documentation
site](https://opal-documentation-rtd.readthedocs.io/en/latest/index.html)  to show you everything.

After you install Opal, here's a few commands to help you explore

Start with `show names` to see all the bash functions. Pro tip: use `fzf` to
filter the list.

```bash
$ show names
```

Pick one of those names and pass it to `desc`, to see how it's defined. For example,
you'll see `opal:today` in the list.

```bash
$ desc opal:today
```

To see where it's defined, pass it to `loc`.

```bash
$ loc opal:today
```

The `cdls` function will change you to the directory you give it, then list the
contents of that directory. The `up` command will navigate you up a number of
directories of your file system.

