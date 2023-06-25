local lsp_ensure_installed = {
  "lua_ls",
  "pyright",
  "yamlls",
  "tsserver"
}

require('mason').setup({ ui = { border = 'rounded' } })
require("mason-lspconfig").setup{ ensure_installed = lsp_ensure_installed }
require("fidget").setup{} -- little progress bar for lsp loading
