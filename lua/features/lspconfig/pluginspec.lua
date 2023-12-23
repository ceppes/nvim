local M = {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/nvim-lsp-installer",
    "SmiteshP/nvim-navic",
    {'mfussenegger/nvim-jdtls', ft = 'java'},
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'j-hui/fidget.nvim',
    "luckasRanarison/clear-action.nvim",
  },
  config = function ()
    require("clear-action").setup()
    require("neodev").setup({})
    require('features.lspconfig.highlight')
    require('features.lspconfig.commands')
    require('features.lspconfig.autocmds')
    require('features.lspconfig.setup')
    require('features.lspconfig.setup_servers')
    require('features.lsp.keymaps').keymaps()
    require('features.lsp.keymaps').diagnostic_keymaps()
  end,
  ft = {
    -- "cs",
    "css",
    -- "go",
    -- "gomod",
    -- "gotmpl",
    -- "haml",
    -- "haskell",
    "html",
    "javascript",
    "javascriptreact",
    "json",
    -- "kotlin",
    -- "less",
    "lua",
    "markdown",
    -- "php",
    "python",
    -- "sass",
    "scss",
    "sh",
    -- "svg",
    -- "tex",
    "toml",
    "typescript",
    "typescript.tsx",
    "typescriptreact",
    -- "vue",
    "xml",
    "yaml",
  },
}

return M
