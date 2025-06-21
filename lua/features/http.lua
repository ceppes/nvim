local M = {}

M = {
    {
        "rest-nvim/rest.nvim",
        -- https://github.com/rest-nvim/rest.nvim/tree/main/spec/examples
        -- https://www.jetbrains.com/help/idea/exploring-http-syntax.html
        ft = { "http, rest" },
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-treesitter/nvim-treesitter",
                opts = function(_, opts)
                    opts.ensure_installed = opts.ensure_installed or {}
                    table.insert(opts.ensure_installed, "http")
                end,
            },
            {
                "vhyrro/luarocks.nvim",
                config = true,
                opts = {
                    rocks = { "lua-curl", "nvim-nio", "mimetypes", "xml2lua" },
                },
            },
        },
        config = function()
            vim.g.rest_nvim = {
                result = {

                    split = {
                        horizontal = false,
                    },
                    behavior = {
                        show_headers = true,
                        show_http_info = true,
                    },
                },
            }

            vim.keymap.set("n", "<leader>rr", "<cmd>Rest run<CR>", { desc = "Rest run" })
            vim.keymap.set("n", "<leader>rl", "<cmd>Rest run last<CR>", { desc = "Rest run last" })
            vim.keymap.set("n", "<leader>rp", "<cmd>Rest run preview<CR>", { desc = "Rest preview curl" })
        end,
    },
}

return M
