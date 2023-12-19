-----------------------------------------------------------
-- Plugin manager configuration file
-----------------------------------------------------------
local data = "~/.local/share/nvim/lazy/"
local state = "~/.local/state/nvim/lazy/"
local lockfile = "~/.config/nvim/lazy-lock.json"

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  require('core.colors'),
  require('features.whichkey'),
  require('features.welcome'),
  require('features.statusline'),
  require('features.tab'),
  require('features.git'),
  require('features.comment'),
  require('features.treesitter'),
  require('features.indent'),
  require('features.telescope.pluginspec'),
  require('features.ui'),
  require('features.trouble'),
  {
    "folke/neodev.nvim",
    config = function() require("neodev").setup({}) end,
    dependencies = {
      "neovim/nvim-lspconfig",
    }
  },
  require('features.lspconfig.pluginspec'),
  require('features.completion'),
  require('features.debugger'),
  require('features.lint'),
  require('features.colorizer'),
  require('features.structure'),
  require('features.session'),
  {
    "nvim-neo-tree/neo-tree.nvim",
    -- branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    keys = {
      { "<leader>ft", "<cmd>Neotree reveal toggle<cr>", desc = "NeoTree" },
    },
    config = function()
      require("neo-tree").setup({
        source_selector = {
          winbar = true,
          status = false,
          sources = {
            { source = "filesystem"},
            { source = "buffers"},
            { source = "git_status"},
            { source = "document_symbols"}
          }
        },
        sources = {
          "filesystem",
          "buffers",
          "git_status",
          "document_symbols"
        }
      })
    end,
  },
  {
    "towolf/vim-helm",
    -- ft = {"yaml"}
  },
  {
    'mbbill/undotree',
    config = function ()
      vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, {desc = 'Undotree Toggle'})
    end
  },
  --  -- Tools
  {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  },
  {
    "windwp/nvim-ts-autotag",
    dependencies = {"nvim-treesitter/nvim-treesitter"},
    config = function() require("nvim-ts-autotag").setup {} end
  },
 --  "onsails/lspkind.nvim",

  -- Dim inactive portions
  "folke/twilight.nvim",

 --  -- better log highlight
  'MTDL9/vim-log-highlighting',
 --

  -- NO MORE USED
  -- "https://git.sr.ht/~whynothugo/lsp_lines.nvim",

  --  "m4xshen/hardtime.nvim",

  -- Distraction free
  -- 'junegunn/goyo.vim',

  -- Markdown
  -- {
  --   "iamcco/markdown-preview.nvim",
  --   run = function()
  --     vim.fn["mkdp#util#install"]()
  --   end,
  --   ft = "markdown",
  --   cmd = { "MarkdownPreview" },
  --   requires = { "zhaozg/vim-diagram", "aklt/plantuml-syntax" },
  -- },
}

require("lazy").setup(plugins)
vim.keymap.set("n", "<leader>l", ":Lazy<CR>", { desc = "Open Lazy"})
-- require("lazy").setup(plugins,opts)

