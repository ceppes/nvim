local M = {}

M.formatter = { "prettier" }
M.lsp_key = "vue_ls"
M.lspbin = "vue-language-server"
M.treesitter = { "vue", "typescript", "javascript" }
M.filetypes = { "vue" }

function M.lsp()
    local lsp_status_ok, lspconfig = pcall(require, "lspconfig")
    if not lsp_status_ok then
        return
    end

    return require("features.lsp.server_config").config({
        filetypes = M.filetypes,
        init_options = {
            vue = {
                hybridMode = true,
            },
            typescript = {
                tsdk = vim.fn.stdpath("data") .. "/mason/packages/typescript-language-server/node_modules/typescript/lib",
            }
        },
        on_init = function(client, initialize_result)
            if client.server_capabilities then
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.documentRangeFormattingProvider = false
            end
        end,
        settings = {},
    })
end

return M
