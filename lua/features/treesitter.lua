----------------------------------------------------------
-- Treesitter configuration file
----------------------------------------------------------

-- Plugin: nvim-treesitter
-- url: https://github.com/nvim-treesitter/nvim-treesitter

local packer = require 'packer'
packer.use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
packer.use 'nvim-treesitter/playground'
local status_ok, nvim_treesitter = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
  return
end

-- See: https://github.com/nvim-treesitter/nvim-treesitter#quickstart
nvim_treesitter.setup {
  ensure_installed = {
    'bash',
    'c',
    'comment',
    'cpp',
    'css',
    'dockerfile',
    'dot',
    'go',
    'help',
    'html',
    'java',
    'javascript',
    'json',
    'hcl',
    'latex',
    'lua',
    'markdown',
    'python',
    'regex',
    'sql',
    'typescript',
    'vim',
    'yaml'
  },
  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,
  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,
  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
