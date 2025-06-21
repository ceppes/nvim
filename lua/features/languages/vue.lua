local M = {}

M.linter = { "eslint_d" }
M.formatter = { "prettier" }
M.lsp_key = "vue_ls"
M.lspbin = "vue-language-server"
M.treesitter = { "vue", "typescript", "javascript" }
M.filetypes = { "vue", "typescript", "javascript" }

function M.lsp()
    local lsp_status_ok, lspconfig = pcall(require, "lspconfig")
    if not lsp_status_ok then
        return
    end

    return require("features.lsp.server_config").config({
        filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
        init_options = {
            vue = {
                hybridMode = false,
            },
        },
    })
end
return M
