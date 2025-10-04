local M = {}

M.lsp_key = "vtsls"
M.lspbin = "vtsls"
M.treesitter = { "vue", "typescript", "javascript" }
M.filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" }

function M.lsp()
    local lsp_status_ok, lspconfig = pcall(require, "lspconfig")
    if not lsp_status_ok then
        return
    end

    return require("features.lsp.server_config").config({
        filetypes = M.filetypes,
        cmd = { M.lspbin, "--stdio" },
        root_markers = {
            "tsconfig.json",
            "package.json",
            "jsconfig.json",
            ".git",
        },
        settings = {
            complete_function_calls = true,
            vtsls = {
                autoUseWorkspaceTsdk = true,
                enableMoveToFileCodeAction = true,
                experimental = {
                    maxInlayHintLength = 30,
                    completion = {
                        enableServerSideFuzzyMatch = true,
                    },
                },
                tsserver = {
                    globalPlugins = {
                        {
                            name = "@vue/typescript-plugin",
                            location = vim.fn.stdpath("data")
                                .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
                            languages = { "vue" },
                            configNamespace = "typescript",
                            enableForWorkspaceTypeScriptVersions = true,
                        },
                    },
                },
            },
            javascript = {
                updateImportsOnFileMove = "always",
            },
            typescript = {
                updateImportsOnFileMove = { enabled = "always" },
                suggest = {
                    completeFunctionCalls = true,
                },
                inlayHints = {
                    enumMemberValues = { enabled = true },
                    functionLikeReturnTypes = { enabled = true },
                    parameterNames = { enabled = "literals" },
                    parameterTypes = { enabled = true },
                    propertyDeclarationTypes = { enabled = true },
                    variableTypes = { enabled = false },
                },
                preferences = {
                    includeCompletionsForModuleExports = true,
                    includeCompletionsForImportStatements = true,
                    importModuleSpecifier = "non-relative",
                },
                -- Stricter diagnostics
                reportStyleChecksAsWarnings = false,
                noImplicitReturns = true,
                noFallthroughCasesInSwitch = true,
                noImplicitOverride = true,
                allowJs = false,
                checkJs = false,
                strict = true,
                noImplicitAny = true,
                strictNullChecks = true,
                strictFunctionTypes = true,
                noImplicitThis = true,
                useUnknownInCatchVariables = true,
                exactOptionalPropertyTypes = true,
                noUncheckedIndexedAccess = true,
                noPropertyAccessFromIndexSignature = true,
            },
        },
    })
end

return M
