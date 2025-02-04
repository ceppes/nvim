-- https://github.com/nvim-treesitter/nvim-treesitter

local M = {}

M = {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'nvim-treesitter/playground'
  },
  build = ':TSUpdate',
  main = 'nvim-treesitter.configs', -- Sets main module to use for opts
  config = function()
    require("features.treesitter").setup()
  end
}

local ensure_installed = {
'c',
'comment',
'cpp',
'diff',
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
  'vimdoc',
}


function M.setup()
  local status_ok, nvim_treesitter = pcall(require, 'nvim-treesitter.configs')
  if not status_ok then
    return
  end

  local servers = require("features.lspconfig.servers")
  for _, config in pairs(servers) do
    if config.treesitter then
      local treesitter_server_config = config.treesitter
      table.insert(ensure_installed, treesitter_server_config)
    end
  end

  nvim_treesitter.setup {
    ensure_installed = ensure_installed,
    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,
    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = false, -- Run :TSUpdate
    ignore_install = {},
    highlight = {
      -- `false` will disable the whole extension
      enable = true,

      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
      -- Using this option may slow down your editor, and you may see some duplicate highlights.
      -- Instead of true it can also be a list of languages

      -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
      --  If you are experiencing weird indenting issues, add the language to
      --  the list of additional_vim_regex_highlighting and disabled languages for indent.
      additional_vim_regex_highlighting = { 'ruby' },
    },
    indent = { enable = true, disable = { 'ruby' } },
    modules = {},
  }

  -- MDX
  vim.filetype.add({
    extension = {
      mdx = "mdx"
    }
  })
  vim.treesitter.language.register("markdown", "mdx")
end

return M
