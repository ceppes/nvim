local M = {}

M = {
    "SmiteshP/nvim-navic",
    lazy = true,
    dependencies = {
        "neovim/nvim-lspconfig",
        "nvim-tree/nvim-web-devicons", -- optional dependency
        "utilyre/barbecue.nvim",
    },
    config = function()
        require("features.winbar").setup()
    end,
}

function M.setup()
    local icons = {
        File = "󰈙 ",
        Module = " ",
        Namespace = "󰌗 ",
        Package = " ",
        Class = "󰌗 ",
        Method = "󰆧 ",
        Property = " ",
        Field = " ",
        Constructor = " ",
        Enum = "󰕘",
        Interface = "󰕘",
        Function = "󰊕 ",
        Variable = "󰆧 ",
        Constant = "󰏿 ",
        String = "󰀬 ",
        Number = "󰎠 ",
        Boolean = "◩ ",
        Array = "󰅪 ",
        Object = "󰅩 ",
        Key = "󰌋 ",
        Null = "󰟢 ",
        EnumMember = " ",
        Struct = "󰌗 ",
        Event = " ",
        Operator = "󰆕 ",
        TypeParameter = "󰊄 ",
    }

    local navic = require("nvim-navic")
    navic.setup({
        icons = icons,
        lsp = {
            auto_attach = false,
            preference = nil,
        },
        highlight = true,
        separator = "  ",
        depth_limit = 5,
        depth_limit_indicator = "..",
        safe_output = true,
        lazy_update_context = true,
        click = false,
        format_text = function(text)
            return text
        end,
    })

    require("barbecue").setup({
        attach_navic = false, -- prevent barbecue from automatically attaching nvim-navic
        create_autocmd = false, -- prevent barbecue from updating itself automatically
        kinds = icons,
        symbols = {
            separator = "",
        },
        exclude_filetypes = { "rest_nvim_result" },
    })

    -- better performance
    vim.api.nvim_create_autocmd({
        "WinScrolled", -- or WinResized on NVIM-v0.9 and higher
        "BufWinEnter",
        "CursorHold",
        "InsertLeave",

        -- include this if you have set `show_modified` to `true`
        "BufModifiedSet",
    }, {
        group = vim.api.nvim_create_augroup("barbecue.updater", {}),
        callback = function()
            require("barbecue.ui").update()
        end,
    })
end

return M
