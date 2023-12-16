
local M = {}

M.lspbin = "json-lsp"
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
