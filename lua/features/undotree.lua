local packer = require 'packer'
packer.use 'mbbill/undotree'

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, {desc = 'Undotree Toggle'})
