local M = {}

M.lsp_key = "texlab"
M.lspbin = "texlab"
M.filetypes = { "tex", "plaintex", "bib" }
M.formatter = { "latexindent" }
M.treesitter = { "latex", "bibtex" }

function M.format()
    local conform = require("conform")
    conform.formatters.latexindent = {
        command = "latexindent",
        args = { "--local", "--silent", "--overwriteIfDifferent", "$FILENAME" },
        stdin = false,
        cwd = require("conform.util").root_file({ ".latexindent.yaml", ".latexindent.yml" }),
        require_cwd = false,
    }
end

function M.lsp()
    return require("features.lsp.server_config").config({})
end

function M.plugin()
    return {
        "lervag/vimtex",
        lazy = false,
        init = function()
            vim.g.vimtex_view_method = "skim"
            vim.g.vimtex_compiler_method = "latexmk"
        end,
        ft = "tex",
    }
end

return M
