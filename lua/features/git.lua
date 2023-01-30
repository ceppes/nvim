local function loadPlugins()
  local packer = require'packer'
  packer.use 'kdheepak/lazygit.nvim'
	packer.use 'tpope/vim-fugitive'
  packer.use 'lewis6991/gitsigns.nvim' -- needed for feline status line
  -- use 'airblade/vim-gitgutter'
end

local function setup()
  require("gitsigns").setup({
    signs = {
      add          = { hl = "GitSignsAdd"   , text = "▋" },
      change       = { hl = "GitSignsChange", text = "▋" },
      delete       = { hl = "GitSignsDelete", text = "▁ " },
      topdelete    = { hl = "GitSignsDelete", text = "▔" },
      changedelete = { hl = "GitSignsChange", text = "▎" },
    },
    current_line_blame = true,
    current_line_blame_opts = {
      delay = 0,
    },
    sign_priority=0 -- for column
  })
end

local function keymaps()
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
  vim.keymap.set('n', '<leader>gb', ':Git blame<CR>', {desc = 'Git blame'})
  vim.keymap.set('n', '<leader>gd', ':Gitsigns diffthis<CR>', {desc = 'Git diff this'})
end

loadPlugins()
setup()
keymaps()
