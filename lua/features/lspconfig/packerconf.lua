local M = {
  "neovim/nvim-lspconfig",
  requires = {
    "williamboman/nvim-lsp-installer",
    "SmiteshP/nvim-navic",
    {'mfussenegger/nvim-jdtls', ft = 'java'},
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'j-hui/fidget.nvim',
    "jayp0521/mason-null-ls.nvim",
    "jose-elias-alvarez/null-ls.nvim",
  },
  config = function ()
    require('features.lspconfig.highlight')
    require('features.lspconfig.commands')
    require('features.lspconfig.autocmds')
    require('features.lspconfig.setup')
    require('features.lspconfig.setup_servers')
  end,
  -- module = "lspconfig",
  ft = {
    -- "cs",
    -- "css",
    -- "go",
    -- "gomod",
    -- "gotmpl",
    -- "haml",
    -- "haskell",
    -- "html",
    -- "javascript",
    -- "javascriptreact",
    "json",
    -- "kotlin",
    -- "less",
    "lua",
    "markdown",
    -- "php",
    "python",
    -- "sass",
    -- "scss",
    "sh",
    -- "svg",
    -- "tex",
    "toml",
    -- "typescript",
    -- "typescriptreact",
    -- "vue",
    "xml",
    "yaml",
  },
}

return M
