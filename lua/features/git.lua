local M = {}

M = {
  {
    'tpope/vim-fugitive',
  },{
    'kdheepak/lazygit.nvim',
    -- use 'airblade/vim-gitgutter'
  },{
    "FabijanZulj/blame.nvim"
  },{
    'lewis6991/gitsigns.nvim', -- needed for feline status line
    config = function()
      require("features.git").setup()
      require("features.git").keymaps()
    end
  }
}

function M.setup()
  require("gitsigns").setup({
    signs = {
      add          = { hl = "GitSignsAdd"   , text = "▋" },
      change       = { hl = "GitSignsChange", text = "▋" },
      delete       = { hl = "GitSignsDelete", text = "▁ " },
      topdelete    = { hl = "GitSignsDelete", text = "▔" },
      changedelete = { hl = "GitSignsChange", text = "▎" },
    },
    current_line_blame = false, -- :Gitsigns toggle_current_line_blame
    -- current_line_blame_opts = {
    --   delay = 0,
    -- },
    sign_priority=0 -- for column
  })
end

function M.keymaps()
  require'which-key'.register({
    g = {
      name = "Git",
    }
  }, {
    mode = "n",
    prefix = "<leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = false,
  })

  local lazygit = require'lazygit'
  vim.keymap.set('n', '<leader>lg', lazygit.lazygit, {desc = "Lazygit"})

  -- Vim fugitive
  vim.keymap.set('n', '<leader>gb', ':ToggleBlame<CR>', {desc = 'Git blame'})
  vim.keymap.set('n', '<leader>gd', ':Gitsigns diffthis<CR>', {desc = 'Git diff this'})
end


return M
