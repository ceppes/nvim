local lsp_status_ok, lspconfig = pcall(require, 'lspconfig')
if not lsp_status_ok then
  return
end
vim.lsp.set_log_level("debug")

local servers = {
  pyright = require('features.languages.python').lsp(),
  lua_ls = require('features.languages.lua').lsp(),
  yamlls = require('features.languages.yaml').lsp(),
  tsserver = require('features.languages.typescript').lsp(),
  cssls = require('features.languages.css').lsp(),
  helm_ls = require('features.languages.helm').lsp(),
}
-- debug
-- :lua vim.inspect(vim.lsp.get_active_clients()))

for server, config in pairs(servers) do
  if config then
    lspconfig[server].setup(config)
  end
end


