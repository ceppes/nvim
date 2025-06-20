local M = {}

M.lsp_key = "clangd"
M.lspbin = "clangd"
M.treesitter = "cpp"
M.filetype = { "c", "cpp", "objc", "objcpp", "cuda", "proto" }

vim.api.nvim_create_autocmd("FileType", {
    pattern = M.filetype,
    group = vim.api.nvim_create_augroup("FixCppCommentString", { clear = true }),
    callback = function()
        vim.bo.commentstring = "//  %s"
        require("Comment.ft")(M.filetype, "// %s")
    end,
})

return M
