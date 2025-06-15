local M = {}

M.linter = "markdownlint"
M.filetype = "markdown"
M.treesitter = { "markdown", "markdown_inline" }

vim.api.nvim_create_autocmd("FileType", {
    pattern = M.filetype,
    callback = function() end,
})

function M.plugin()
    return {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {},
    }
end

return M
