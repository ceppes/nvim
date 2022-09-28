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
  use "ellisonleao/gruvbox.nvim"
  use 'folke/tokyonight.nvim'

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
      'hrsh7th/cmp-nvim-lsp-signature-help',
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
  -- use 'airblade/vim-gitgutter'
	use 'tpope/vim-fugitive'

  use {'lewis6991/gitsigns.nvim'} -- needed for feline

  -- Distraction free
  use 'junegunn/goyo.vim'

  -- Linting
  use 'mfussenegger/nvim-lint'

  -- Comment
  use 'numToStr/Comment.nvim'

  -- Tools
  use "folke/which-key.nvim"
  use {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  }

  use "https://git.sr.ht/~whynothugo/lsp_lines.nvim"
  use "kyazdani42/nvim-web-devicons"
  use "onsails/lspkind.nvim"

  -- Structure
  use 'simrat39/symbols-outline.nvim'

  -- debugger
  use {
    'mfussenegger/nvim-dap',
    wants = {
      "nvim-dap-virtual-text",
      "nvim-dap-ui",
      "nvim-dap-python",
      "which-key.nvim"
    },
    requires = {
      "theHamsta/nvim-dap-virtual-text",
      "rcarriga/nvim-dap-ui",
      "mfussenegger/nvim-dap-python",
      "nvim-telescope/telescope-dap.nvim",
      "jbyuki/one-small-step-for-vimkind",
    },
  }

  use 'norcalli/nvim-colorizer.lua'
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
  }
  use 'j-hui/fidget.nvim'

end)
