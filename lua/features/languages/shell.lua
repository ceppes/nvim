local M = {}

M.linter = "shellcheck"
M.filetypes = "sh"
M.treesitter = "bash"
M.formatter = "shfmt"

vim.api.nvim_create_autocmd("FileType", {
    pattern = M.filetypes,
    callback = function()
        vim.opt_local.shiftwidth = 2
        vim.opt_local.tabstop = 2
        vim.opt_local.foldmethod = "indent"
        vim.opt_local.expandtab = true
    end,
})

function M.format()
    require("conform").formatters.shfmt = {
      inherit = false,
      command = "shfmt",
      args = function ()
        local shiftwidth = vim.opt.shiftwidth:get()
        local expandtab = vim.opt.expandtab:get()

        if not expandtab then
            shiftwidth = 0
        end

        return {"--diff", "--indent", "2", "--case-indent", "-filename", "$FILENAME" }
      end
    }
end

return M
