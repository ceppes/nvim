-----------------------------------------------------------
-- Plugin manager configuration file
-----------------------------------------------------------

local cmd = vim.cmd
cmd [[packadd packer.nvim]]

local packer = require 'packer'

packer.startup(function()
  use 'wbthomason/packer.nvim' -- packer can manage itself

  -- Tag viewer
  use 'liuchengxu/vista.vim'

  -- Distraction free
  use 'junegunn/goyo.vim'

  -- Linting
  use 'mfussenegger/nvim-lint'

  -- Tools
  use "folke/which-key.nvim"
  use {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  }
  use {
    "windwp/nvim-ts-autotag",
    config = function() require("nvim-ts-autotag").setup {} end
  }

  use "https://git.sr.ht/~whynothugo/lsp_lines.nvim"

  use "kyazdani42/nvim-web-devicons"
  use "onsails/lspkind.nvim"

  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
  }
  use 'j-hui/fidget.nvim'

  -- Markdown
  use {
    "iamcco/markdown-preview.nvim",
    run = function()
      vim.fn["mkdp#util#install"]()
    end,
    ft = "markdown",
    cmd = { "MarkdownPreview" },
    requires = { "zhaozg/vim-diagram", "aklt/plantuml-syntax" },
  }

  --welcome screen
  use {'goolord/alpha-nvim'}
  use {'MTDL9/vim-log-highlighting'}

end)

vim.keymap.set('n', '<leader>ps', packer.sync, {desc = 'Packer Sync'})
