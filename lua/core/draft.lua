--Disable saving backup file
vim.opt.backup = false
-- vim.o.undodir = "~/.config/nvim/undodir/"
-- vim.opt.undodir = vim.fn.stdpath('data') .. '/undodir'
-- Keep undo history across sessions, by storing in file
vim.opt.undofile = true

vim.bo.softtabstop = 4
vim.bo.shiftwidth = 2

vim.opt.signcolumn = "yes"
vim.opt.wrap = true
