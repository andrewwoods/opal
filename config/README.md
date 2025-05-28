
# Using XDG_CONFIG_DIRS in Neovim

This Opal Neovim Config directory is meant to be a supplemental config
directory for Neovim users that use Opal. The Opal Project provides default
settings files, to help users get started quickly.

## XDG_CONFIG_DIRS

These directories should be the top level directories.
In your `.bash_profile`  add the following line

```bash
# My setting
XDG_CONFIG_DIRS='$HOME/opal/config'
```

Like `PATH`, the `XDG_CONFIG_DIRS` is a colon delimited list.

## Neovim Runtime PATH

in their init.lua file, you need to add the config_dirs to the runtimepath.
Then, for each file in the `$HOME/opal/config/nvim/lua` you want, add a require
call with the filename (minus the .lua extension).

This example pulls in the dates.lua file to simplify writing the current date,
in a variety of date formats.

```lua
vim.opt.rtp:prepend(vim.fn.stdpath("config_dirs"))


require("dates")
```


