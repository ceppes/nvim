local M = {}

function M.attach(client, bufnr)
    require("features.lsp.diagnostics").setup()

    vim.api.nvim_buf_set_var(bufnr, "lsp_attached", true)

    local navic_ok, navic = pcall(require, "nvim-navic")
    local navbuddy = require("nvim-navbuddy")

    if navic_ok then
        if client.server_capabilities.documentSymbolProvider then
            -- Only attach navic to first LSP server to avoid conflicts
            local navic_attached = pcall(vim.api.nvim_buf_get_var, bufnr, "nvim_navic_attached")
            if not navic_attached then
                navic.attach(client, bufnr)
                navbuddy.attach(client, bufnr)
                vim.api.nvim_buf_set_var(bufnr, "nvim_navic_attached", true)
            end
        end
    end
end

return M
