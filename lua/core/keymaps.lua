-- ██╗  ██╗███████╗██╗   ██╗██████╗ ██╗███╗   ██╗██████╗ ██╗███╗   ██╗ ██████╗ ███████╗
-- ██║ ██╔╝██╔════╝╚██╗ ██╔╝██╔══██╗██║████╗  ██║██╔══██╗██║████╗  ██║██╔════╝ ██╔════╝
-- █████╔╝ █████╗   ╚████╔╝ ██████╔╝██║██╔██╗ ██║██║  ██║██║██╔██╗ ██║██║  ███╗███████╗
-- ██╔═██╗ ██╔══╝    ╚██╔╝  ██╔══██╗██║██║╚██╗██║██║  ██║██║██║╚██╗██║██║   ██║╚════██║
-- ██║  ██╗███████╗   ██║   ██████╔╝██║██║ ╚████║██████╔╝██║██║ ╚████║╚██████╔╝███████║
-- ╚═╝  ╚═╝╚══════╝   ╚═╝   ╚═════╝ ╚═╝╚═╝  ╚═══╝╚═════╝ ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝

-----------------------------------------------------------
-- Define keymaps of Neovim and installed plugins.
-----------------------------------------------------------

-- map({mode}, {keymap}, {mapped to}, {options})
-- mode ( i : insert, n : normal)
local function map(mode, lhs, rhs, opts)
  -- noremap : no recursive mapping
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Change leader to a space
vim.g.mapleader = ' '

-----------------------------------------------------------
-- Neovim shortcuts
-----------------------------------------------------------

-- Clear search highlighting with <leader> and c
map('n', '<leader>c', ':nohl<CR>')

-- Map Esc to kk
--map('i', 'kk', '<Esc>')

-- Don't use arrow keys
map('', '<up>', '<nop>')
map('', '<down>', '<nop>')
map('', '<left>', '<nop>')
map('', '<right>', '<nop>')

-- Ctrl-s to save
map('n', '<C-s>', ':w<CR>', {})
map('i', '<C-s>', '<ESC>:w<CR>a', {})

-- Fast saving with <leader> and s
map('n', '<leader>w', ':w<CR>')
--map('i', '<leader>s', '<C-c>:w<CR>')

-- Fast saving with ss
map('n', 'ss', ':w<CR>')

-- Move around splits using Ctrl + {h,j,k,l}
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

-- Close all windows and exit from Neovim with <leader> and q
map('n', '<leader>q', ':qa!<CR>')

-- Access netrw (temp)
map('n', '<leader>e', ':Ex<CR>')

-----------------------------------------------------------
-- Applications and Plugins shortcuts
-----------------------------------------------------------

-- NvimTree
--map('n', '<C-n>', ':NvimTreeToggle<CR>')            -- open/close
--map('n', '<leader>f', ':NvimTreeRefresh<CR>')       -- refresh
--map('n', '<leader>n', ':NvimTreeFindFile<CR>')      -- search file

-- Vista tag-viewer
--map('n', '<C-m>', ':Vista!!<CR>') -- open/close

-- Telescope
-- Find files using Telescope command-line sugar.
map('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
map('n', '<leader>feh', '<cmd>Telescope find_files hidden=true<cr>')
map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
map('n', '<leader>fb', '<cmd>Telescope buffers<cr>')
map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>')
map('n', '<leader>fr', '<cmd>Telescope resume<cr>')
map('n', '<leader>fp', '<cmd>Telescope pickers<cr>')

-- Using Lua functions
--map('n', '<leader>ff', "<cmd>lua require('telescope.builtin').find_files()<cr>")
--map('n', '<leader>fg', "<cmd>lua require('telescope.builtin').live_grep()<cr>")
--map('n', '<leader>fb', "<cmd>lua require('telescope.builtin').buffers()<cr>")
--map('n', '<leader>fh', "<cmd>lua require('telescope.builtin').help_tags()<cr>")


-- Lazygit
map('n', '<leader>lg', ':LazyGit<CR>')

-- Vim fugitive
map('n', '<leader>gb', ':Git blame<CR>')
map('n', '<leader>gd', ':Gitsigns diffthis<CR>')


-- Goyo, distraction free
-- map('n', '<leader>g', ':Goyo 100%<CR>')
-- map('n', '<leader>G', ':Goyo!<CR>')

-- Open structure (outlint)
map('n', '<leader>v', '<cmd>SymbolsOutline<cr>')
