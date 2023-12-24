local M = {}

M.lsp_key = 'cssls'
M.lspbin = 'vscode-css-language-server'
M.debugger = ''
M.treesitter = 'css'

function M.lsp()
  local lsp_status_ok, lspconfig = pcall(require, 'lspconfig')
  if not lsp_status_ok then
    return
  end

  return require("features.lsp.server_config").config(
    M.lspbin,
    {
      cmd = {"vscode-css-language-server", "--stdio"},
      filetypes = {"css", "scss", "less"},
      root_dir = lspconfig.util.root_pattern("package.json", ".git"),
    }
  )
end

return M
