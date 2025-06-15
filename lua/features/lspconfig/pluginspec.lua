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
    },
    config = function()
        require("neodev").setup({})
        require("features.lspconfig.highlight")
        require("features.lspconfig.commands")
        require("features.lspconfig.autocommand").autocommand()
        require("features.lspconfig.setup")
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

return M
