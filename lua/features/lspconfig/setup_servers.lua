-- All client
vim.lsp.config("*", {
    capabilities = {
        textDocument = {
            semanticTokens = {
                multilineTokenSupport = true,
            },
        },
    },
    root_markers = { ".git" },
})
-- log path :
-- v ~/.cache/nvim/lsp.log
-- v ~/.local/state/nvim/dapui.log

vim.lsp.set_log_level("debug")

-- debug
-- :lua vim.inspect(vim.lsp.get_active_clients()))
local servers = require("features.lspconfig.servers")

local log = ""
for _, config in pairs(servers) do
    if type(config.lsp) == "function" and config.lsp_key then
        local lsp = config.lsp()

        vim.lsp.config(config.lsp_key, lsp)

        if vim.fn.executable(config.lspbin) ~= 1 then
            log = log .. "\n" .. "[LSP][Setup servers] ❌ " .. config.lsp_key .. ", bin : " .. config.lspbin .. " "
        else
            log = log .. "\n" .. "[LSP][Setup servers] ✅ " .. config.lsp_key .. ", bin : " .. config.lspbin .. " "
        end
    end
end
