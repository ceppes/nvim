require'which-key'.register({
  f = {
    name = "Find",
  }
}, {
  mode = "n",
  prefix = "<leader>",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
})

local builtin = require'telescope.builtin'

vim.keymap.set('n', '<leader>ff', builtin.find_files, {desc = 'T Find files'} )
vim.keymap.set('n', '<leader>feh', function ()
    builtin.find_files({hidden = true})
  end,
  {desc = 'T Find files with hidden'} )
vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = "T Git files"})
vim.keymap.set('n', '<leader>fl', builtin.live_grep, { desc = "T Live grep"})
vim.keymap.set('n', '<leader>fs', function ()
    builtin.grep_string({ search = vim.fn.input("Grep > ")});
  end,
  {desc = 'T Grep string'})
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "T Buffers"})
vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = "T Keymaps"})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "T Help tag"})
vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = "T Resume"})
vim.keymap.set('n', '<leader>fp', builtin.pickers, { desc = "T Pickers"})


-- TODO google telescope.buitlin.grep_string
-- local options = { noremap = true, silent = true }
-- vim.keymap.set(
--   'n',
--   '<leader>fs',
--   function ()
--     local telescope = require('Telescope')
--     telescope.builtin.grep_string()
--   end,
--   options)
