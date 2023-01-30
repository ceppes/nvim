--[[
██╗  ██╗███████╗██╗   ██╗██████╗ ██╗███╗   ██╗██████╗ ██╗███╗   ██╗ ██████╗ ███████╗
██║ ██╔╝██╔════╝╚██╗ ██╔╝██╔══██╗██║████╗  ██║██╔══██╗██║████╗  ██║██╔════╝ ██╔════╝
█████╔╝ █████╗   ╚████╔╝ ██████╔╝██║██╔██╗ ██║██║  ██║██║██╔██╗ ██║██║  ███╗███████╗
██╔═██╗ ██╔══╝    ╚██╔╝  ██╔══██╗██║██║╚██╗██║██║  ██║██║██║╚██╗██║██║   ██║╚════██║
██║  ██╗███████╗   ██║   ██████╔╝██║██║ ╚████║██████╔╝██║██║ ╚████║╚██████╔╝███████║
╚═╝  ╚═╝╚══════╝   ╚═╝   ╚═════╝ ╚═╝╚═╝  ╚═══╝╚═════╝ ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝
--]]

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
map('n', '<leader>cs', ':nohl<CR>')

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

vim.keymap.set('n', '<leader>e', vim.cmd.Ex, { desc = "Access netrw" })
-- vim.cmd.Ex
-----------------------------------------------------------
-- Applications and Plugins shortcuts
-----------------------------------------------------------

-- NvimTree
--map('n', '<C-n>', ':NvimTreeToggle<CR>')            -- open/close
--map('n', '<leader>f', ':NvimTreeRefresh<CR>')       -- refresh
--map('n', '<leader>n', ':NvimTreeFindFile<CR>')      -- search file

-- Vista tag-viewer
--map('n', '<C-m>', ':Vista!!<CR>') -- open/close

-- Goyo, distraction free
-- map('n', '<leader>g', ':Goyo 100%<CR>')
-- map('n', '<leader>G', ':Goyo!<CR>')

-- Trouble
map('n', '<leader>xx', '<cmd>TroubleToggle<cr>')
map('n', '<leader>xw', '<cmd>TroubleToggle workspace_diagnostics<cr>')
map('n', '<leader>xd', '<cmd>TroubleToggle document_diagnostics<cr>')
map('n', '<leader>xl', '<cmd>TroubleToggle loclist<cr>')
map('n', '<leader>xq', '<cmd>TroubleToggle quickfix<cr>')
map('n', '<leader>xr', '<cmd>TroubleToggle lsp_references<cr>')

-- paste over currently selected text without yanking it
vim.keymap.set('v', '<leader>p', '"_dP', { desc = 'Over paste' })

vim.keymap.set('n', '<leader>y', '"+y', { desc = 'Copy to system' })
vim.keymap.set('v', '<leader>y', '"+y', { desc = 'Copy to system' })
vim.keymap.set('n', '<leader>Y', 'gg"+yG', { desc = 'Copy all file to system' })

-- map('n', '<leader>d', '"_d')
-- map('v', '<leader>d', '"_d')

vim.keymap.set('n', '<leader>ft', function() vim.lsp.buf.format() end, { desc = 'Format buffer' })

vim.keymap.set('n', '<leader>jq', '<cmd>%!jq .<cr>', { desc = 'Format json' })
vim.keymap.set('n', '<leader>jqs', '<cmd>%!jq -S .<cr>', { desc = 'Format json and sort by name' })

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = "Move visual line up" })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = "Move visual line down" })

vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = "Go up with keeping cursor in the middle" })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = "Go down with keeping cursor in the middle" })

vim.keymap.set('n', 'n', 'nzzzv', { desc = "Next search inc with cursor in the middle" })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = "Next search inc with cursor in the middle" })

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], {desc = "Live replace word"})
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "chmod +x current_file" })
