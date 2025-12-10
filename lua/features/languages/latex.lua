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

return M
