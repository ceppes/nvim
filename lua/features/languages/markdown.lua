local M = {}

M.linter = "markdownlint"
M.filetype = { "markdown" }
M.treesitter = { "markdown", "markdown_inline" }


function M.plugin()
    return {
        "MeanderingProgrammer/render-markdown.nvim",
        name = "render-markdown",
        ft = "markdown",
        dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {},
    }
end

return M
