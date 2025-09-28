-- https://github.com/nvim-treesitter/nvim-treesitter

local M = {}

M = {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
        {
            "nvim-treesitter/playground",
            cmd = "TSPlaygroundToggle",
        },
        {
            "windwp/nvim-ts-autotag",
            lazy = true,
            dependencies = { "nvim-treesitter/nvim-treesitter" },
            config = function()
                require("nvim-ts-autotag").setup({})
            end,
        },
    },
    build = ":TSUpdate",
    main = "nvim-treesitter.configs", -- Sets main module to use for opts
    config = function()
        require("features.treesitter").setup()
    end,
}

local ensure_installed_m = {
    "c",
    "comment",
    "cpp",
    "diff",
    "dockerfile",
    "dot",
    "git_config",
    "git_rebase",
    "gitcommit",
    "gitignore",
    "go",
    "gomod",
    "http",
    "jsonc",
    "hcl",
    "latex",
    "luadoc",
    "query", -- treesitter
    "regex",
    "terraform",
    "vim",
    "vimdoc",
}

function M.setup()
    local status_ok, nvim_treesitter = pcall(require, "nvim-treesitter.configs")
    if not status_ok then
        return
    end

    local servers = require("features.lspconfig.servers")

    local added = {}
    for _, lang in ipairs(ensure_installed_m) do
        added[lang] = true
    end

    for _, server in pairs(servers) do
        local ts = server.treesitter
        if ts then
            if type(ts) == "table" then
                for _, lang in pairs(ts) do
                    added[lang] = true
                end
            else
                added[ts] = true
            end
        end
    end

    local ensure_installed = vim.tbl_keys(added)
    table.sort(ensure_installed)

    -- vim.print(ensure_installed)

    nvim_treesitter.setup({
        ensure_installed = ensure_installed,
        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,
        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        auto_install = false, -- Run :TSUpdate
        ignore_install = {},
        highlight = {
            -- `false` will disable the whole extension
            enable = true,

            -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
            -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
            -- Using this option may slow down your editor, and you may see some duplicate highlights.
            -- Instead of true it can also be a list of languages

            -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
            --  If you are experiencing weird indenting issues, add the language to
            --  the list of additional_vim_regex_highlighting and disabled languages for indent.
            additional_vim_regex_highlighting = { "ruby" },
        },
        indent = { enable = true, disable = { "ruby" } },
        fold = { enable = true },
        modules = {},
    })

    -- MDX
    vim.filetype.add({
        extension = {
            mdx = "mdx",
        },
    })
    vim.treesitter.language.register("markdown", "mdx")
end

return M
