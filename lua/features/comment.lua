local M = {}

M = {
    {
        "numToStr/Comment.nvim",
        lazy = false,
        opts = {},
    },
    {
        "folke/todo-comments.nvim",
        event = "BufReadPost",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        opts = { signs = false },
    },
}

return M
