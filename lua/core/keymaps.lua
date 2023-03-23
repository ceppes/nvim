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
vim.keymap.set('n', '<leader>cs', ':nohl<CR>', { desc = "Clear search highlighting"})

-- Don't use arrow keys
vim.keymap.set('', '<up>', '<nop>')
vim.keymap.set('', '<down>', '<nop>')
vim.keymap.set('', '<left>', '<nop>')
vim.keymap.set('', '<right>', '<nop>')

vim.keymap.set('n', '<C-s>', ':w<CR>', { desc = "Save"})
vim.keymap.set('i', '<C-s>', '<ESC>:w<CR>a', { desc = "Save"})
vim.keymap.set('n', '<leader>w', ':w<CR>', { desc = "Save"})
vim.keymap.set('n', 'ss', ':w<CR>', { desc = "Save"})
vim.keymap.set('n', 'sa', ':wa<CR>', { desc = "Save all"})

-- Move around splits using Ctrl + {h,j,k,l}
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

vim.keymap.set('n', '<leader>q', ':qa!<CR>', { desc = "Close all windows and exit"})

vim.keymap.set('n', '<leader>e', vim.cmd.Ex, { desc = "Access netrw" })

-----------------------------------------------------------
-- Applications and Plugins shortcuts
-----------------------------------------------------------

-- Trouble

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

-- Map Esc to kk
--map('i', 'kk', '<Esc>')

-- Goyo, distraction free
-- map('n', '<leader>g', ':Goyo 100%<CR>')
-- map('n', '<leader>G', ':Goyo!<CR>')
