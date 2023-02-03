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

vim.keymap.set('n', '<leader>c', require('telescope.builtin').colorscheme, { desc = "T Colorscheme"})

-- For markdown checkbox highlight
require('catppuccin').setup{
  styles = {
    comment = {},
  }
}
