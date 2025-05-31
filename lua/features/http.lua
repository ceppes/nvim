local M = {}

M = {
    {
        "vhyrro/luarocks.nvim",
        priority = 1000,
        config = true,
        opts = {
            rocks = { "lua-curl", "nvim-nio", "mimetypes", "xml2lua" },
        },
    },
    {
        "rest-nvim/rest.nvim",
        -- https://github.com/rest-nvim/rest.nvim/tree/main/spec/examples
        ft = "http, rest",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            opts = function(_, opts)
                opts.ensure_installed = opts.ensure_installed or {}
                table.insert(opts.ensure_installed, "http")
            end,
        },
        config = function()
            vim.keymap.set("n", "<leader>rr", "<cmd>Rest run<CR>", { desc = "Rest run" })
        end,
    },
}

return M
