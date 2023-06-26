-----------------------------------------------------------
-- Plugin manager configuration file
-----------------------------------------------------------
vim.cmd.packadd('packer.nvim')

local packer_helper = require('features.packer')
packer_helper.keymap()

local plugins = {
  require('features.whichkey').plugins,
  require('features.telescope').plugins,
  require('features.notify').plugins,
  require('features.trouble').plugins,
  require('features.lspconfig.packerconf'),
  require('features.debugger').plugins,
  require('features.lint').plugins,
  require('features.git').plugins,
  require('features.statusline').plugins,
  require('features.completion').plugins,
  require('features.treesitter').plugins,
  require('features.comment').plugins,
  require('features.indent').plugins,
  require('features.colorizer').plugins,
  require('features.structure').plugins,
  require('features.tab').plugins,
  require('features.welcome').plugins,
  require('features.session').plugins,
  require('features.ui').plugins,
  require('core.colors').plugins,
 {
   'mbbill/undotree',
   config = function ()
    vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, {desc = 'Undotree Toggle'})
   end
 },

  -- Tag viewer
  'liuchengxu/vista.vim',

  -- Distraction free
  'junegunn/goyo.vim',

  -- Tools
  {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  },
  {
    "windwp/nvim-ts-autotag",
    config = function() require("nvim-ts-autotag").setup {} end
    -- require treesiter
  },

  "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  "kyazdani42/nvim-web-devicons",
  "onsails/lspkind.nvim",

  -- Markdown
  {
    "iamcco/markdown-preview.nvim",
    run = function()
      vim.fn["mkdp#util#install"]()
    end,
    ft = "markdown",
    cmd = { "MarkdownPreview" },
    requires = { "zhaozg/vim-diagram", "aklt/plantuml-syntax" },
  },

  -- better log highlight
  'MTDL9/vim-log-highlighting',
}

print("pacer")
local packer = require('packer')
packer.init({
  snapshot = vim.env.HOME .. "/.dotfiles/nvim/snapshots/snapshot-main", -- Snapshot name to load at startup
  snapshot_path = vim.env.HOME .. "/.dotfiles/nvim/snapshots/" -- Snapshot save path,
})

packer.startup(packer_helper.use(plugins))
