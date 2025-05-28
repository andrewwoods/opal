--[[
	Date Formats
	============
--]]

vim.cmd("iab <expr> now_date strftime('%Y %b %d %a')")
vim.cmd("iab <expr> now_time strftime('%H:%M')")

vim.cmd("iab <expr> iso_date strftime('%Y-%m-%d')")
vim.cmd("iab <expr> iso_datetime strftime('%Y-%m-%dT%H:%M%z')")
vim.cmd("iab <expr> iso_timestamp strftime('%Y-%m-%dT%H:%M:%S%z')")

vim.cmd("iab <expr> opal_date strftime('%Y %b %d %a')")
vim.cmd("iab <expr> opal_datetime strftime('%Y %b %d %a %H:%M')")
vim.cmd("iab <expr> opal_timestamp strftime('%Y %b %d %a %H:%M:%S%z')")

vim.cmd("iab <expr> world_date strftime('%d.%m.%Y')")
vim.cmd("iab <expr> world_datetime strftime('%d.%m.%Y %H:%M')")
vim.cmd("iab <expr> world_timestamp strftime('%d.%m.%Y %H:%M:%S%z')")

vim.cmd("iab <expr> us_date strftime('%m/%d/%Y')")
vim.cmd("iab <expr> us_datetime strftime('%m/%d/%Y %l:%M%p')")
vim.cmd("iab <expr> us_timestamp strftime('%m/%d/%Y %l:%M:%S%p %z')")

vim.cmd("iab <expr> file_date strftime('%Y-%m-%d')")
vim.cmd("iab <expr> file_datetime strftime('%Y-%m-%d-%H-%M')")
vim.cmd("iab <expr> file_timestamp strftime('%Y-%m-%d-%H-%M-%S')")
