local M = {}

M.hover = {
  ["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover,
    {border = "rounded",}
  ),
  ["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      underline = true,
      update_in_insert = false,
      virtual_text = {
        spacing = 4,
        prefix = "\u{ea71}"
      },
      severity_sort = true
    }
  )
}

return M
