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





-- vim.cmd.packadd('packer.nvim')
--
-- local packer_helper = require('features.packer')
-- packer_helper.keymap()

--local lsputil = require("lspconfig.util")
-- vim.keymap.set

local plugins = {
  require('core.colors'),
  require('features.whichkey'),
  require('features.telescope.pluginspec'),
  require('features.notify'),
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
  require('features.git'),
  require('features.statusline'),
  require('features.treesitter'),
  require('features.comment'),
  require('features.indent'),
  require('features.colorizer'),
  require('features.structure'),
  require('features.tab'),
  require('features.welcome'),
  require('features.session'),
  require('features.ui'),
 {
   'mbbill/undotree',
   config = function ()
    vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, {desc = 'Undotree Toggle'})
   end
 },
 --
 --
 --  -- Tools
  {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  },
  {
    "windwp/nvim-ts-autotag",
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
-- require("lazy").setup(plugins,opts)

-- local packer = require('packer')
-- packer.startup{
--   packer_helper.use(plugins),
--   config = {
--     snapshot = vim.env.HOME .. "/.dotfiles/nvim/snapshots/snapshot-main.json", -- Snapshot name to load at startup
--     snapshot_path = vim.env.HOME .. "/.dotfiles/nvim/snapshots/" -- Snapshot save path,
--   }
-- }
