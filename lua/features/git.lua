local M = {}

M = {
  {
    'tpope/vim-fugitive',
    keys = {
      { '<leader>gb', ':BlameToggle<CR>', {desc = '[G]it [B]lame'} },
      { '<leader>gd', ':Gitsigns diffthis<CR>', {desc = '[G]it [D]iff this'} }
    }
  },{
    'kdheepak/lazygit.nvim',
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
        { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
    },
    config = function()
      require("telescope").load_extension("lazygit")
    end,
  },{
    "FabijanZulj/blame.nvim",
    lazy = false,
    config = function()
      require('blame').setup {}
    end,
  },{
    'lewis6991/gitsigns.nvim', -- needed for feline status line
    config = function()
      require("features.git").setup()
      require("features.git").keymaps()
    end
  }
    -- use 'airblade/vim-gitgutter'
}

function M.setup()
  vim.api.nvim_set_hl(0, 'GitSignsAdd', { link = 'GitSignsAdd' })
  vim.api.nvim_set_hl(0, 'GitSignsChange', { link = 'GitSignsChange' })
  vim.api.nvim_set_hl(0, 'GitSignsChangedelete', { link = 'GitSignsChange' })
  vim.api.nvim_set_hl(0, 'GitSignsDelete', { link = 'GitSignsDelete' })
  vim.api.nvim_set_hl(0, 'GitSignsTopdelete', { link = 'GitSignsDelete' })

  require("gitsigns").setup({
    current_line_blame = false, -- :Gitsigns toggle_current_line_blame
    sign_priority = 0 -- for column
  })

end

function M.keymaps()
  require("which-key").add({
    { "<leader>g", group = "Git" },
  })
end


return M
