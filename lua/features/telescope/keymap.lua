require("which-key").add({
  { "<leader>f", group = "Find" },
  { "<leader>fh", group = "Hidden" },
})

local builtin = require'telescope.builtin'

vim.keymap.set('n', '<leader>ff', builtin.find_files, {desc = 'T Files'} )
vim.keymap.set('n', '<leader>fhf', function ()
    builtin.find_files({hidden = true})
  end,
  {desc = 'T Find files with hidden'} )
vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = "T Git files"})
vim.keymap.set('n', '<leader>fl', builtin.live_grep, { desc = "T Live grep"})
vim.keymap.set('n', '<leader>fhl', function ()
    builtin.live_grep({
      additional_args = function(_)
        return { "--hidden" }
      end
    })
  end, { desc = "T Live grep with hidden"})
vim.keymap.set('n', '<leader>fs', function ()
    builtin.grep_string();
    -- builtin.grep_string({ search = vim.fn.input("Grep > ")});
  end,
  {desc = 'T Grep string'})
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "T Buffers"})
vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = "T Keymaps"})
vim.keymap.set('n', '<leader>ft', builtin.help_tags, { desc = "T Help tag"})
vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = "T Resume"})
vim.keymap.set('n', '<leader>fp', builtin.pickers, { desc = "T Pickers"})
vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = "T Diagnostic"})



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
