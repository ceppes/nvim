local M = {}

M.hover = {
  ["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover,
    {border = "rounded",}
  ),
}

return M
