local M = {}

M.filetypes = {"html", "xhtml"}

vim.api.nvim_create_autocmd("FileType", {
  pattern = M.filetypes,
  callback = function()
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 2
    vim.opt_local.foldmethod='indent'
    vim.opt_local.expandtab = true
  end
})

return M
