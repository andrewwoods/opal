
--[[
 These match the format names match in opal:get_aate_format()
 but uses underscores instead of dashes due to the use of
 dashes as a word separator causes a syntax error.
--]]

vim.cmd("iabbrev <expr> unix_time strftime('%s')") --
vim.cmd("iabbrev <expr> opal_date strftime('%Y %b %d %a')")  -- 2024 Apr 28 Sun
vim.cmd("iabbrev <expr> opal_datetime strftime('%Y %b %d %a %H:%M')") -- 2024 Apr 28 Sun 21:34
vim.cmd("iabbrev <expr> opal_timestamp strftime('%Y %b %d %a %H:%M:%S%z')") -- 2024 Apr 28 Sun 21:33:59-0400

vim.cmd("iabbrev <expr> iso_date strftime('%Y-%m-%d')")  -- 2024-04-27
vim.cmd("iabbrev <expr> iso_datetime strftime('%Y-%m-%dT%H:%M')") -- 2024-04-28T21:33:39-0400
vim.cmd("iabbrev <expr> iso_timestamp strftime('%Y-%m-%dT%H:%M:%S%z')") -- 2024-04-28T21:31:10-0400

vim.cmd("iabbrev <expr> world_date strftime('%d.%m.%Y')")  -- 28.04.2024
vim.cmd("iabbrev <expr> world_datetime strftime('%d.%m.%Y %H:%M')") -- 28.04.2024 21:27
vim.cmd("iabbrev <expr> world_timestamp strftime('%d.%m.%Y %H:%M:%S%z')") -- 28.04.2024 21:27:40-0400

vim.cmd("iabbrev <expr> us_date strftime('%m/%d/%Y')")  -- 04/28/2024
vim.cmd("iabbrev <expr> us_datetime strftime('%m/%d/%Y %l:%M%p')") -- 04/28/2024  9:27PM
vim.cmd("iabbrev <expr> us_timestamp strftime('%m/%d/%Y %l:%M:%S%p %z')") -- 04/28/2024  9:26:46PM -0400

vim.cmd("iabbrev <expr> filename_date strftime('%Y-%m-%d')")  -- 2024-04-28
vim.cmd("iabbrev <expr> filename_datetime strftime('%Y-%m-%d-%H-%M')") -- 2024-04-28-21-26
vim.cmd("iabbrev <expr> filename_timestamp strftime('%Y-%m-%d-%H-%M-%S')") -- 2024-04-28-21-26-15

vim.cmd("iabbrev <expr> time12 strftime('%I:%M:%S %p')") -- 09:38:25 PM
vim.cmd("iabbrev <expr> time24 strftime('%H:%M:%S')") -- 21:38:34

