local packer = require 'packer'
packer.use 'simrat39/symbols-outline.nvim'

local symbols_outline = require("symbols-outline")

symbols_outline.setup()

vim.keymap.set('n', '<leader>v', symbols_outline.toggle_outline, {desc = 'Open Structure'})
