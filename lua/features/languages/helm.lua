local M = {}

M.lsp_key = "helm_ls"
M.lspbin = "helm_ls"
M.debugger = ""

function M.lsp()
    local lsp_status_ok, lspconfig = pcall(require, "lspconfig")
    if not lsp_status_ok then
        return
    end

    return require("features.lsp.server_config").config(M.lspbin, {
        cmd = { "helm_ls", "serve" },
        filetypes = { "helm", "yaml", "yml" },
        root_markers = function(fname)
            return lspconfig.util.root_pattern("Chart.yaml")(fname)
        end,
    })
end

return M
