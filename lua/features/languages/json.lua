
local M = {}

M.lspbin = "json-lsp"
M.lspbin = "vscode-json-language-server"
M.treesitter = "json"

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
