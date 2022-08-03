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
  use {
    "williamboman/nvim-lsp-installer",
    "neovim/nvim-lspconfig",
  }
  --LSP Java
  use {'mfussenegger/nvim-jdtls', ft = 'java'}

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

  -- Indent
  use 'lukas-reineke/indent-blankline.nvim'

  -- Git
  use 'kdheepak/lazygit.nvim'
  use 'airblade/vim-gitgutter'
	use 'tpope/vim-fugitive'

  -- Distraction free
  use 'junegunn/goyo.vim'

  -- Linting
  use 'mfussenegger/nvim-lint'

  -- Comment
  use 'numToStr/Comment.nvim'

  -- Tools
  use "folke/which-key.nvim"

  use "https://git.sr.ht/~whynothugo/lsp_lines.nvim"

end)
