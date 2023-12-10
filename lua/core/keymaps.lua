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

local keymap = vim.keymap
local opts = { noremap = true, silent = true}

-- Change leader to a space
vim.g.mapleader = ' '

-----------------------------------------------------------
-- Neovim shortcuts
-----------------------------------------------------------
keymap.set('n', '<leader>cs', ':nohl<CR>', { desc = "Clear search highlighting"})

-- Don't use arrow keys
keymap.set('', '<up>', '<nop>')
keymap.set('', '<down>', '<nop>')
keymap.set('', '<left>', '<nop>')
keymap.set('', '<right>', '<nop>')

keymap.set('n', '<C-s>', ':w<CR>', { desc = "Save"})
keymap.set('i', '<C-s>', '<ESC>:w<CR>a', { desc = "Save"})
keymap.set('n', '<leader>w', ':w<CR>', { desc = "Save"})
keymap.set('n', 'ss', ':w<CR>', { desc = "Save"})
keymap.set('n', 'sa', ':wa<CR>', { desc = "Save all"})

-- Move around splits using Ctrl + {h,j,k,l}
keymap.set('n', '<C-h>', '<C-w>h')
keymap.set('n', '<C-j>', '<C-w>j')
keymap.set('n', '<C-k>', '<C-w>k')
keymap.set('n', '<C-l>', '<C-w>l')

keymap.set('n', '<leader>q', ':qa!<CR>', { desc = "Close all windows and exit"})

keymap.set('n', '<leader>e', vim.cmd.Ex, { desc = "Access netrw" })

-----------------------------------------------------------
-- Applications and Plugins shortcuts
-----------------------------------------------------------

-- Trouble

-- paste over currently selected text without yanking it
keymap.set('v', '<leader>p', '"_dP', { desc = 'Over paste' })

keymap.set('n', '<leader>y', '"+y', { desc = 'Copy to system' })
keymap.set('v', '<leader>y', '"+y', { desc = 'Copy to system' })
keymap.set('n', '<leader>Y', 'gg"+yG', { desc = 'Copy all file to system' })

-- map('n', '<leader>d', '"_d')
-- map('v', '<leader>d', '"_d')

keymap.set('n', '<leader>ft', function() vim.lsp.buf.format() end, { desc = 'Format buffer' })

keymap.set('n', '<leader>jq', '<cmd>%!jq .<cr>', { desc = 'Format json' })
keymap.set('n', '<leader>jqs', '<cmd>%!jq -S .<cr>', { desc = 'Format json and sort by name' })
keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = "Move visual line up" })
keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = "Move visual line down" })

keymap.set('n', '<C-d>', '<C-d>zz', { desc = "Go up with keeping cursor in the middle" })
keymap.set('n', '<C-u>', '<C-u>zz', { desc = "Go down with keeping cursor in the middle" })

keymap.set('n', 'n', 'nzzzv', { desc = "Next search inc with cursor in the middle" })
keymap.set('n', 'N', 'Nzzzv', { desc = "Next search inc with cursor in the middle" })

keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], {desc = "Live replace word"})
keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "chmod +x current_file" })

-- Map Esc to kk
--map('i', 'kk', '<Esc>')

-- Goyo, distraction free
-- map('n', '<leader>g', ':Goyo 100%<CR>')
-- map('n', '<leader>G', ':Goyo!<CR>')
