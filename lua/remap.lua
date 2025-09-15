vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set('n', '<leader>ex', vim.cmd.Ex)

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])
vim.keymap.set('n', '<leader>Y', [["+Y]])

vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]])

vim.keymap.set('i', '<C-c>', '<Esc>')

-- Nicer movement between splits
vim.keymap.set("n", "<C-j>", "<c-w>j")
vim.keymap.set("n", "<C-k>", "<c-w>k")
vim.keymap.set("n", "<C-l>", "<c-w>l")
vim.keymap.set("n", "<C-h>", "<c-w>h")

-- Easier size adjusting
vim.keymap.set("n", "<C-left>", "<c-w>5<")
vim.keymap.set("n", "<C-right>", "<c-w>5>")
vim.keymap.set("n", "<C-up>", "<C-W>+")
vim.keymap.set("n", "<C-down>", "<C-W>-")
