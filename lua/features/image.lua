return {
    {
        "3rd/image.nvim",
        build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
        lazy = false,
        priority = 1000,
        config = function()
            require("image").setup({
                processor = "magick_cli",
            })
        end,
    },
    {
        "3rd/diagram.nvim",
        dependencies = { "3rd/image.nvim" },
        ft = { "markdown", "norg" },
        config = function()
            local auto_render_enabled = false
            local auto_events = { "InsertLeave", "BufWinEnter", "TextChanged" }

            require("diagram").setup({
                events = {
                    render_buffer = {},
                    clear_buffer = { "BufLeave" },
                },
                renderer_options = {
                    mermaid = {
                        theme = "default",
                        scale = 2,
                    },
                },
            })

            vim.api.nvim_create_user_command("DiagramAutoRenderToggle", function()
                auto_render_enabled = not auto_render_enabled
                require("diagram").setup({
                    events = {
                        render_buffer = auto_render_enabled and auto_events or {},
                        clear_buffer = { "BufLeave" },
                    },
                    renderer_options = {
                        mermaid = {
                            theme = "default",
                            scale = 2,
                        },
                    },
                })
                print("Diagram auto-render: " .. (auto_render_enabled and "ON" or "OFF"))
            end, { desc = "Toggle diagram auto-render" })
        end,
        keys = {
            {
                "<leader>md",
                function()
                    require("diagram").show_diagram_hover()
                end,
                mode = "n",
                ft = { "markdown", "norg" },
                desc = "Show diagram",
            },
        },
    },
}
