-----------------------------------------------------------
-- Plugin manager configuration file
-----------------------------------------------------------
local data = "~/.local/share/nvim/lazy/"
local state = "~/.local/state/nvim/lazy/"
local lockfile = "~/.config/nvim/lazy-lock.json"

-- Install lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        error("Error cloning lazy.nvim:\n" .. out)
    end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

local plugins = {
    require("core.colors"),
    require("features.whichkey"),
    require("features.welcome"),
    require("features.statusline"),
    require("features.tab"),
    require("features.git"),
    require("features.comment"),
    require("features.treesitter"),
    require("features.indent"),
    require("features.telescope.pluginspec"),
    require("features.ui"),
    require("features.trouble"),
    require("features.winbar"),
    {
        "folke/neodev.nvim",
        event = "BufReadPre",
        config = function()
            require("neodev").setup({})
        end,
        dependencies = {
            "neovim/nvim-lspconfig",
        },
    },
    require("features.lspconfig.pluginspec"),
    require("features.completion"),
    require("features.debugger"),
    require("features.test"),
    -- require('features.null-ls'),
    require("features.lint"),
    require("features.format"),
    require("features.sonar"),
    require("features.colorizer"),
    require("features.structure"),
    require("features.session"),
    require("features.http"),
    require("features.filetree"),
    require("features.mini"),
    require("features.ia"),
    require("features.languages.markdown").plugin(),
    require("features.languages.sql").plugin(),
    require("features.languages.log").plugin(),
    {
        "towolf/vim-helm",
        -- ft = {"yaml"}
    },
    {
        "mbbill/undotree",
        config = function()
            vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Undotree Toggle" })
        end,
    },
    -- Tools
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup({})
        end,
    },
    --  "onsails/lspkind.nvim",

    -- Dim inactive portions
    "folke/twilight.nvim",

    -- NO MORE USED
    -- "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    --  "m4xshen/hardtime.nvim",
    -- Distraction free
    -- 'junegunn/goyo.vim',
    -- Markdown
    -- {
    --   "iamcco/markdown-preview.nvim",
    --   run = function()
    --     vim.fn["mkdp#util#install"]()
    --   end,
    --   ft = "markdown",
    --   cmd = { "MarkdownPreview" },
    --   requires = { "zhaozg/vim-diagram", "aklt/plantuml-syntax" },
    -- },
}

require("lazy").setup(plugins)

vim.keymap.set("n", "<leader>l", ":Lazy<CR>", { desc = "Open Lazy" })
