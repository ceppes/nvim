local M = {}

M.lsp_key = "tailwindcss"
M.lspbin = "tailwindcss-language-server"
M.filetypes = {
    "ejs",
    "html",
    "css",
    "scss",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "vue",
}

function M.lsp()
    return require("features.lsp.server_config").config({
        filetypes = M.filetypes,
        root_markers = {
            "tailwind.config.js",
            "tailwind.config.cjs",
            "tailwind.config.mjs",
            "tailwind.config.ts",
            "postcss.config.js",
            "postcss.config.cjs",
            "postcss.config.mjs",
            "postcss.config.ts",
            "package.json",
            "node_modules",
        },
        settings = {
            tailwindCSS = {
                classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
                includeLanguages = {
                    eelixir = "html-eex",
                    elixir = "phoenix-heex",
                    eruby = "erb",
                    heex = "phoenix-heex",
                    htmlangular = "html",
                    templ = "html",
                },
                lint = {
                    cssConflict = "warning",
                    invalidApply = "error",
                    invalidConfigPath = "error",
                    invalidScreen = "error",
                    invalidTailwindDirective = "error",
                    invalidVariant = "error",
                    recommendedVariantOrder = "warning",
                },
                validate = true,
            },
        },
    })
end

return M
