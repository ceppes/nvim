-----------------------------------------------------------
-- Plugin manager configuration file
-----------------------------------------------------------

local cmd = vim.cmd
cmd [[packadd packer.nvim]]

local packer = require 'packer'

-- Add packages
return packer.startup(function()
  use 'wbthomason/packer.nvim' -- packer can manage itself

  -- LSP
  use 'neovim/nvim-lspconfig'
  --LSP Java
  
  use 'mfussenegger/nvim-jdtls'

  --Color Scheme
  use { "ellisonleao/gruvbox.nvim" }

  --  Status Line
  use 'feline-nvim/feline.nvim'


end)
