local M = {}

M.lsp_key = "ts_ls"
M.lspbin = "typescript-language-server"
M.treesitter = { "typescript", "tsx", "javascript" }
M.filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" }
M.formatter = { "prettierd", "prettier" }

vim.api.nvim_create_autocmd("FileType", {
    pattern = M.filetypes,
    callback = function()
        vim.bo.shiftwidth = 2
        vim.bo.tabstop = 2
        vim.opt_local.foldmethod = "indent"
        vim.opt_local.expandtab = true
    end,
})

function M.lsp()
    local lsp_status_ok, lspconfig = pcall(require, "lspconfig")
    if not lsp_status_ok then
        return
    end

    local root_files = {
        "package.json",
        "tsconfig.json",
        ".git",
    }

    return require("features.lsp.server_config").config({
        filetypes = M.filetypes,
        cmd = { M.lspbin, "--stdio" },
        root_markers = lspconfig.util.root_pattern(unpack(root_files)),
        settings = {
            typescript = {
                tsserver = {
                    useSyntaxServer = false,
                },
                inlayHints = {
                    includeInlayParameterNameHints = "literal",
                    includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                    includeInlayFunctionParameterTypeHints = true,
                    includeInlayVariableTypeHints = false,
                    includeInlayPropertyDeclarationTypeHints = true,
                    includeInlayFunctionLikeReturnTypeHints = true,
                    includeInlayEnumMemberValueHints = true,
                },
            },
        },
        init_options = {
            plugins = {
                {
                    name = "@vue/typescript-plugin",
                    location = vim.fn.stdpath("data") .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
                    languages = { "vue" },
                    configNamespace = "typescript",
                    enableForWorkspaceTypeScriptVersions = true,
                },
            },
        },
    })
end

return M
