-- https://github.com/nvim-treesitter/nvim-treesitter

local M = {}

M = {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'nvim-treesitter/playground'
  },
  -- run = function()
  --     local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
  --     ts_update()
  -- end,
  config = function()
    require("features.treesitter").setup()
  end
}

local ensure_installed = {
  'bash',
  'c',
  -- 'comment',
  'cpp',
  'dockerfile',
  'dot',
  'git_config',
  'git_rebase',
  'gitcommit',
  'gitignore',
  'go',
  'gomod',
  'html',
  'http',
  'javascript',
  'jsonc',
  'hcl',
  'latex',
  'luadoc',
  'markdown',
  'query', -- treesitter
  'regex',
  'scss',
  'sql',
  'terraform',
  'vim',
}


function M.setup()
  local status_ok, nvim_treesitter = pcall(require, 'nvim-treesitter.configs')
  if not status_ok then
    return
  end

  local servers = require("features.lspconfig.servers")
  for _, config in pairs(servers) do
    if config.treesitter then
      local treesitter = config.treesitter
      table.insert(ensure_installed, treesitter)
    end
  end

  nvim_treesitter.setup {
    ensure_installed = ensure_installed,
    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,
    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = false, -- Run :TSUpdate
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
