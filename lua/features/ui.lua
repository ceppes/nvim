local M = {}

M = {
    {
        "rcarriga/nvim-notify",
        lazy = true,
        config = function()
            require("features.ui").setup()
            require("features.ui").keymaps()
        end,
    },
    {
        "stevearc/dressing.nvim",
        opts = {},
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            presets = {
                lsp_doc_border = true,
                inc_rename = true,
            },
            lsp = {
                signature = {
                    enabled = false,
                },
            },
        },
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            "rcarriga/nvim-notify",
        },
    },
}

function M.setup()
    require("notify").setup({
        background_colour = "#000000",
        timeout = 6000, --5000 default

        render = "wrapped-default",
        stages = "fade_in_slide_out",
        max_width = math.floor(vim.o.columns * 0.8), -- e.g., 80% of your screen
    })
    vim.notify = require("notify")

    require("telescope").load_extension("notify")
end

function M.keymaps()
    local notify = require("notify")

    -- Close last notification
    vim.keymap.set("n", "<leader>nc", function()
        notify.dismiss({ pending = false, silent = false })
    end, { desc = "Close last notification" })

    -- Close all notifications
    vim.keymap.set("n", "<leader>na", function()
        notify.dismiss({ silent = true, pending = true })
    end, { desc = "Close all notifications" })

    vim.keymap.set("n", "<leader>fN", function()
        require("telescope").extensions.notify.notify()
    end, { desc = "[F]ind [N]otificaton history" })
end
return M
