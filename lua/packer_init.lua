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

  -- Tag viewer
  use 'liuchengxu/vista.vim'

  -- Treesitter interface
  use 'nvim-treesitter/nvim-treesitter'

  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- Completion
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      --  Use luasnip
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      --'hrsh7th/cmp-cmdline',
      --'hrsh7th/cmp-calc',
      --'f3fora/cmp-spell',
    },
  }

end)
