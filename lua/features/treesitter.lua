-- https://github.com/nvim-treesitter/nvim-treesitter

local M = {}

M = {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        "nvim-treesitter/playground",
    },
    build = ":TSUpdate",
    main = "nvim-treesitter.configs", -- Sets main module to use for opts
    config = function()
        require("features.treesitter").setup()
    end,
}

local ensure_installed_m = {
    c = true,
    comment = true,
    cpp = true,
    diff = true,
    dockerfile = true,
    dot = true,
    git_config = true,
    git_rebase = true,
    gitcommit = true,
    gitignore = true,
    go = true,
    gomod = true,
    html = true,
    http = true,
    javascript = true,
    jsonc = true,
    hcl = true,
    latex = true,
    luadoc = true,
    markdown = true,
    query = true, -- treesitter
    regex = true,
    scss = true,
    sql = true,
    terraform = true,
    vim = true,
    vimdoc = true,
}

function M.setup()
    local status_ok, nvim_treesitter = pcall(require, "nvim-treesitter.configs")
    if not status_ok then
        return
    end

    local servers = require("features.lspconfig.servers")
    for _, serverName in pairs(servers) do
        if serverName.treesitter then
            local treesitter_server_config = serverName.treesitter
            if type(treesitter_server_config) == "table" then
                for _, config in pairs(treesitter_server_config) do
                    ensure_installed_m[config] = true
                end
            else
                ensure_installed_m[treesitter_server_config] = true
            end
        end
    end

    local ensure_installed = {}

    for serverName, _ in ipairs(ensure_installed_m) do
        table.insert(ensure_installed, tostring(serverName))
        print(serverName)
    end

    for k, v in ipairs(ensure_installed_m) do
        print(k .. v)
    end
    for k, v in ipairs(ensure_installed) do
        print(k .. v)
    end

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
