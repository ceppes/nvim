local M = {}

M.lspbin = "gopls"
M.lsp_key = "gopls"

function M.lsp()
    local lsp_status_ok, lspconfig = pcall(require, "lspconfig")
    if not lsp_status_ok then
        return
    end

    return require("features.lsp.server_config").config(M.lspbin, {
        { "go", "gomod", "gowork", "gotmpl" },
    })
end

return M
