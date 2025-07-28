vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", ":Lexplore!<cr>", {
    desc = "Toggle the [F]ile [E]xplorer",
})

vim.keymap.set("n", "<leader>?", ":help ", {
    desc = "Search the Help for a string",
})

vim.keymap.set("n", "<leader>/", ":vimgrep <cword> **<cr>", {
    desc = "Search for a string in the project",
})

vim.keymap.set("n", "<leader>so", ":so<cr>", {
    desc = "Source the current file",
})

vim.keymap.set("n", "<leader>dk", ":map<cr>", {
    desc = "[D]isplay [K]eymaps",
})

-- Quick Fix List
vim.keymap.set("n", "<leader>qo", ":copen<cr>", {
    desc = "[Q]uickfix List [O]pen",
})

vim.keymap.set("n", "<leader>qq", ":cclose<cr>", {
    desc = "[Q]uickfix List Close/[Q]uit",
})

vim.keymap.set("n", "<leader>qn", ":cnext<cr>", {
    desc = "[Q]uickfix List [N]ext",
})

vim.keymap.set("n", "<leader>qp", ":cprev<cr>", {
    desc = "[Q]uickfix List [P]rev",
})

-- Keep the search result centered
vim.keymap.set("n", "n", "nzzzv", { desc = "Go to next search result" })

vim.keymap.set("n", "N", "Nzzzv", { desc = "Go to prev search result" })

-- yanks text into the System Clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], {
    desc = "Yank text to the System Clipboard",
})

vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Delete the text for good by using the Black Hole register
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], {
    desc = "Delete text using the Black Hole Register",
})

-- No Op > Do nothing
vim.keymap.set("n", "Q", "<nop>", { desc = "Do nothing" })

-- Move visually selected lines up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", {
    desc = "Move selected lines down",
})

vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", {
    desc = "Move selected lines up",
})
