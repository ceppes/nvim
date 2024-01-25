
local M = {}

M.lsp_key = 'jsonls'
M.lspbin = "json-lsp"
M.lspbin = "vscode-json-language-server"
M.treesitter = "json"
M.lint = "jsonlint"

function M.lsp()
  return require("features.lsp.server_config").config(
    M.lspbin,
    {
      filetypes = {
        "json", "jsonc"
      }
    }
  )
end

return M
