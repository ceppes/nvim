local M = {}

M.filetype = "sql"
M.treesitter = "sql"

function M.plugin()
    M.keymaps()
    return {
        {
            "tpope/vim-dadbod",
        },
        {
            "kristijanhusak/vim-dadbod-completion",
        },
        {
            "kristijanhusak/vim-dadbod-ui",
            dependencies = {
                { "tpope/vim-dadbod", lazy = true },
                { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
            },
            cmd = {
                "DBUI",
                "DBUIToggle",
                "DBUIAddConnection",
                "DBUIFindBuffer",
            },
            init = function()
                -- Your DBUI configuration
                vim.g.db_ui_use_nerd_fonts = 1
            end,
        },
    }
end

function M.keymaps()
    vim.keymap.set("n", "<leader>udb", ":DBUIToggle<CR>", { desc = "Open Dadbod UI" })
end

return M
