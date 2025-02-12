local lsp_status_ok, lspconfig = pcall(require, 'lspconfig')
if not lsp_status_ok then
  return
end
-- log path :
-- v ~/.cache/nvim/lsp.log
-- v ~/.local/state/nvim/dapui.log

vim.lsp.set_log_level("debug")

-- debug
-- :lua vim.inspect(vim.lsp.get_active_clients()))
local servers = require("features.lspconfig.servers")

local log  = ""
for server, config in pairs(servers) do
  if config.lsp and config.lsp_key then
    local lsp = config.lsp()
    lspconfig[config.lsp_key].setup(lsp)
    if vim.fn.executable(config.lspbin) ~= 1 then
        log = log .. "\n" .. "[LSP][Setup servers] ❌ " .. config.lsp_key .. ", bin : " .. config.lspbin .. " ";
      else
        log = log .. "\n" .. "[LSP][Setup servers] ✅ " .. config.lsp_key .. ", bin : " .. config.lspbin .. " ";
    end
  end
end

-- vim.notify(log)
