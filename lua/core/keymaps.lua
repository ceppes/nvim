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

map('n', '<leader>tc', "<cmd>lua require('telescope.builtin').colorscheme()<cr>")
map('n', 'gR', "<cmd>lua require('telescope.builtin').lsp_references()<cr>", {desc = 'Telescope Lsp References'})
map('n', 'gD', "<cmd>lua require('telescope.builtin').lsp_definitions()<cr>", {desc = 'Telescope Lsp Definitions'})

-- Using Lua functions
--map('n', '<leader>ff', "<cmd>lua require('telescope.builtin').find_files()<cr>")
--map('n', '<leader>fg', "<cmd>lua require('telescope.builtin').live_grep()<cr>")
--map('n', '<leader>fb', "<cmd>lua require('telescope.builtin').buffers()<cr>")
--map('n', '<leader>fh', "<cmd>lua require('telescope.builtin').help_tags()<cr>")


-- Lazygit
map('n', '<leader>lg', ':LazyGit<CR>')

-- Vim fugitive
map('n', '<leader>gb', ':Git blame<CR>', {desc = 'Git blame'})
map('n', '<leader>gd', ':Gitsigns diffthis<CR>', {desc = 'Git diff this'})


-- Goyo, distraction free
-- map('n', '<leader>g', ':Goyo 100%<CR>')
-- map('n', '<leader>G', ':Goyo!<CR>')

-- Open structure (outlint)
map('n', '<leader>v', '<cmd>SymbolsOutline<cr>', {desc = 'Open Symbols Outline'})

-- Trouble
map('n', '<leader>xx', '<cmd>TroubleToggle<cr>')
map('n', '<leader>xw', '<cmd>TroubleToggle workspace_diagnostics<cr>')
map('n', '<leader>xd', '<cmd>TroubleToggle document_diagnostics<cr>')
map('n', '<leader>xl', '<cmd>TroubleToggle loclist<cr>')
map('n', '<leader>xq', '<cmd>TroubleToggle quickfix<cr>')
map('n', '<leader>xr', '<cmd>TroubleToggle lsp_references<cr>')

-- paste over currently selected text without yanking it
map('v', '<leader>p', '"_dP', {desc = 'over paste'})
-- map('n', '<leader>y', '"+y')
-- map('v', '<leader>y', '"+y')
-- map('n', '<leader>Y', 'gg"+yG')
-- map('n', '<leader>d', '"_d')
-- map('v', '<leader>d', '"_d')

map('n', '<leader>ft', '<cmd>lua vim.lsp.buf.format()<cr>', {desc = 'Format buffer'})

map('n', '<leader>tn', '<cmd>tabnew<cr>', {desc = 'New tab'})
map('n', '<leader>tx', '<cmd>tabclose<cr>', {desc = 'Close tab'})


