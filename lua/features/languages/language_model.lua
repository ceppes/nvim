
local M = {}

M.lsp_key = ""
M.lspbin = ""
M.debugger = ""
M.treesitter = {""}
M.filhtype = { ""}
M.linter = {""}
M.formatter = { "" }

vim.api.nvim_create_autocmd("FileType", {
    pattern = M.filetypes,
    callback = function()
    end,
})

function M.lsp()
end

function M.plugin()
end


function M.keymaps()
end

function M.debugger()
end

return M
