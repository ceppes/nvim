local lsp_status_ok, lspconfig = pcall(require, 'lspconfig')
if not lsp_status_ok then
  return
end
vim.lsp.set_log_level("debug")

-- debug
-- :lua vim.inspect(vim.lsp.get_active_clients()))
local servers = require("features.lspconfig.servers")

for server, config in pairs(servers) do
  if config.lsp then
    local lsp = config.lsp()
    lspconfig[server].setup(lsp)
  end
end


