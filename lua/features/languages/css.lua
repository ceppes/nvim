local M = {}

M.lsp_key = 'cssls'
M.lspbin = 'vscode-css-language-server'
M.debugger = ''
M.treesitter = 'css'
M.filetypes = {"css", "scss", "less"}

vim.api.nvim_create_autocmd("FileType", {
  pattern = M.filetypes,
  callback = function()
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 2
    vim.opt_local.foldmethod='indent'
    vim.opt_local.expandtab = true
  end
})

function M.lsp()
  local lsp_status_ok, lspconfig = pcall(require, 'lspconfig')
  if not lsp_status_ok then
    return
  end

  return require("features.lsp.server_config").config(
    M.lspbin,
    {
      cmd = {"vscode-css-language-server", "--stdio"},
      filetypes = M.filetypes,
      root_dir = lspconfig.util.root_pattern("package.json", ".git"),
    }
  )
end

return M
