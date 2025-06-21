local M = {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/nvim-lsp-installer",
        "SmiteshP/nvim-navic",
        { "mfussenegger/nvim-jdtls", ft = "java" },
        { "williamboman/mason.nvim", opts = {} },
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        { "j-hui/fidget.nvim", opts = {} },
        { "luckasRanarison/clear-action.nvim", opts = {} },
        "smjonas/inc-rename.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "SmiteshP/nvim-navbuddy",
        dependencies = {
            "SmiteshP/nvim-navic",
            "MunifTanjim/nui.nvim",
        },
        opts = { lsp = { auto_attach = true } },
    },
    config = function()
        require("neodev").setup({})
        require("features.lspconfig.highlight")
        require("features.lspconfig.commands")
        require("features.lspconfig.autocommand").autocommand()
        require("features.lspconfig.pluginspec").setup()
        require("features.lspconfig.setup_servers")
        require("features.lsp.keymaps").keymaps()
        require("features.lsp.keymaps").diagnostic_keymaps()

        require("inc_rename").setup({
            -- input_buffer_type = "dressing",
        })
    end,
    ft = {
        -- "cs",
        "css",
        -- "go",
        -- "gomod",
        -- "gotmpl",
        -- "haml",
        -- "haskell",
        "html",
        "javascript",
        "javascriptreact",
        "json",
        -- "kotlin",
        -- "less",
        "lua",
        "markdown",
        -- "php",
        "python",
        -- "sass",
        "scss",
        "sh",
        -- "svg",
        -- "tex",
        "toml",
        "typescript",
        "typescript.tsx",
        "typescriptreact",
        -- "vue",
        "xml",
        "yaml",
    },
}

function M.setup()
    vim.print("setup")
    local protocol = require("vim.lsp.protocol")
    protocol.CompletionItemKind = {
        "", -- Text
        "", -- Method
        "", -- Function
        "", -- Constructor
        "", -- Field
        "", -- Variable
        "", -- Class
        "ﰮ", -- Interface
        "", -- Module
        "", -- Property
        "", -- Unit
        "", -- Value
        "", -- Enum
        "", -- Keyword
        "﬌", -- Snippet
        "", -- Color
        "", -- File
        "", -- Reference
        "", -- Folder
        "", -- EnumMember
        "", -- Constant
        "", -- Struct
        "", -- Event
        "ﬦ", -- Operator
        "", -- TypeParameter
    }

    require("mason").setup({ ui = { border = "rounded" } })

    require("mason-lspconfig").setup({
        handlers = {
            function(server_name)
                local server = servers[server_name] or {}
                -- This handles overriding only values explicitly passed
                -- by the server configuration above. Useful when disabling
                -- certain features of an LSP (for example, turning off formatting for ts_ls)
                server.capabilities =
                    vim.tbl_deep_extend("force", {}, require("features.lsp.capabilities"), server.capabilities or {})
                require("lspconfig")[server_name].setup(server)
            end,
        },
    })

end

return M
