local M = {}

M.linter = ''
M.lspbin = 'vscode-css-language-server'
M.debugger = ''

function M.lsp()
  local lsp_status_ok, lspconfig = pcall(require, 'lspconfig')
  if not lsp_status_ok then
    return
  end

  return require("features.lsp.server_config").config(
    M.lspbin,
    {
      root_dir = lspconfig.util.root_pattern("package.json", ".git"),
      filetypes = {"css", "scss", "less"},
      cmd = {"vscode-css-language-server", "--stdio"}
    }
  )
end

return M
