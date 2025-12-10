local M = {}

M = {
    {
        "tpope/vim-fugitive",
        keys = {
            { "<leader>gb", ":BlameToggle<CR>", { desc = "[G]it [B]lame" } },
            { "<leader>gd", ":Gitsigns diffthis<CR>", { desc = "[G]it [D]iff this" } },
        },
    },
    {
        "kdheepak/lazygit.nvim",
        lazy = true,
        cmd = {
            "LazyGit",
            "LazyGitConfig",
            "LazyGitCurrentFile",
            "LazyGitFilter",
            "LazyGitFilterCurrentFile",
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
        -- setting the keybinding for LazyGit with 'keys' is recommended in
        -- order to load the plugin when the command is run for the first time
        keys = {
            { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
        },
        config = function()
            require("telescope").load_extension("lazygit")
        end,
    },
    {
        "FabijanZulj/blame.nvim",
        lazy = false,
        config = function()
            require("blame").setup({})
        end,
    },
    {
        "lewis6991/gitsigns.nvim", -- needed for feline status line
        event = "BufReadPre",
        config = function()
            require("features.git").setup()
            require("features.git").keymaps()
        end,
    },
    {
        "sindrets/diffview.nvim",
        cmd = "DiffviewOpen",
        config = function()
            local actions = require("diffview.actions")
            require("diffview").setup({
                keymaps = {
                    file_panel = {
                        -- Lazygit
                        ["s"] = false,
                        {
                            "n",
                            "<leader><leader>",
                            actions.toggle_stage_entry,
                            { desc = "Stage / unstage the selected entry" },
                        },
                        ["S"] = false,
                        { "n", "<leader>a", actions.stage_all, { desc = "Stage all entries" } },
                    },
                },
            })
        end,
    },
    {
        "esmuellert/vscode-diff.nvim",
        dependencies = { "MunifTanjim/nui.nvim" },
        cmd = "CodeDiff",
    },
    -- use 'airblade/vim-gitgutter'
}

function M.setup()
    -- Catppuccin Mocha colors for better visibility
    vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#a6e3a1", bold = true }) -- Green
    vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#f9e2af", bold = true }) -- Yellow
    vim.api.nvim_set_hl(0, "GitSignsChangedelete", { fg = "#fab387", bold = true }) -- Peach
    vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#f38ba8", bold = true }) -- Red
    vim.api.nvim_set_hl(0, "GitSignsTopdelete", { fg = "#f38ba8", bold = true }) -- Red

    require("gitsigns").setup({
        current_line_blame = false, -- :Gitsigns toggle_current_line_blame
        sign_priority = 0, -- for column
    })
end

function M.keymaps()
    require("which-key").add({
        { "<leader>g", group = "Git" },
    })

    local function toggle_diffview(cmd)
        if next(require("diffview.lib").views) == nil then
            vim.cmd(cmd)
        else
            vim.cmd("DiffviewClose")
        end
    end

    vim.keymap.set("n", "<leader>gd", function()
        toggle_diffview("DiffviewOpen")
    end, { desc = "Diff Index" })

    vim.keymap.set("n", "<leader>gD", function()
        toggle_diffview("DiffviewOpen master..HEAD")
    end, { desc = "Diff master" })

    vim.keymap.set("n", "<leader>gf", function()
        toggle_diffview("DiffviewFileHistory %")
    end, { desc = "Diffs for current File" })

    vim.keymap.set("n", "<leader>gdd", function()
        vim.cmd("CodeDiff file HEAD")
    end, { desc = "Diff Index" })
end

return M
