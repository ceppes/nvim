local M = {}

M.plugins = {
  'nvim-treesitter/nvim-treesitter',
  requires = {
    'nvim-treesitter/playground'
  },
  run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
  end,
  config = function()
    require("features.treesitter").setup()
  end
}

local ensure_installed = {
  'bash',
  'c',
  'comment',
  'cpp',
  'css',
  'dockerfile',
  'dot',
  'go',
  -- 'help',
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
}


function M.setup()
  local status_ok, nvim_treesitter = pcall(require, 'nvim-treesitter.configs')
  if not status_ok then
    return
  end

  nvim_treesitter.setup {
    ensure_installed = ensure_installed,
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
end

return M
