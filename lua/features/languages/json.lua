local M = {}

M.lsp_key = "jsonls"
M.lspbin = "json-lsp"
M.lspbin = "vscode-json-language-server"
M.treesitter = "json"
M.linter = "jsonlint"
M.filetypes = "json"

vim.api.nvim_create_autocmd("FileType", {
    pattern = M.filetypes,
    callback = function()
        vim.bo.formatexpr = ""
        vim.bo.formatprg = "jq"
    end,
})

function M.lsp()
    return require("features.lsp.server_config").config({
        filetypes = {
            "json",
            "jsonc",
        },
    })
end

return M
