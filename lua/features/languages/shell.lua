local M = {}

M.linter = "shellcheck"
M.filetype = "sh"
M.treesitter = "bash"
M.formatter = "shfmt"

vim.api.nvim_create_autocmd("FileType", {
    pattern = "sh",
    callback = function()
        vim.opt_local.shiftwidth = 2
        vim.opt_local.tabstop = 2
        vim.opt_local.foldmethod = "indent"
        vim.opt_local.expandtab = true
    end,
})

-- test
-- :verbose set tabstop?

return M
