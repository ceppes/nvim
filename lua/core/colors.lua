local packer = require 'packer'
packer.use "ellisonleao/gruvbox.nvim"
packer.use 'folke/tokyonight.nvim'
packer.use { "catppuccin/nvim", as = "catppuccin" }

function ColorIt(color)
  color = color or "catppuccin-mocha"
  vim.cmd.colorscheme(color)
end

ColorIt()

vim.o.background = "dark"

local telescope_builtin_status_ok, telescope_builtin = pcall(require, 'telescope.builtin')
if not telescope_builtin_status_ok then
  return
end
vim.keymap.set('n', '<leader>c', require('telescope.builtin').colorscheme, { desc = "T Colorscheme"})

-- For markdown checkbox highlight
require('catppuccin').setup{
  styles = {
    comment = {},
  }
}
