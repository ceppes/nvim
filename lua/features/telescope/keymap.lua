require("which-key").add({
  { "<leader>f", group = "Find" },
  { "<leader>fh", group = "Hidden" },
})

local builtin = require 'telescope.builtin'

vim.keymap.set('n', '<leader>ff', builtin.find_files, {desc = 'T Files'} )
vim.keymap.set('n', '<leader>fhf', function ()
    builtin.find_files({hidden = true})
  end,
  {desc = 'T Files with hidden'} )
vim.keymap.set('n', '<leader>fl', builtin.live_grep, { desc = "T Live grep"})
vim.keymap.set('n', '<leader>fhl', function ()
    builtin.live_grep({
      additional_args = function(_)
        return { "--hidden" }
      end
    })
  end, { desc = "T Live grep with hidden"})
vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = "T Git files"})
vim.keymap.set('n', '<leader>fs', builtin.grep_string, {desc = 'T Find current word'})
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "T Buffers"})
vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = "T Keymaps"})
vim.keymap.set('n', '<leader>ft', builtin.help_tags, { desc = "T Help tag"})
vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = "T Resume"})
vim.keymap.set('n', '<leader>fp', builtin.pickers, { desc = "T Pickers"})
vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = "T Diagnostic"})
vim.keymap.set('n', '<leader>fbb', builtin.builtin, { desc = "T Telescope"})
vim.keymap.set('n', '<leader>fH', builtin.command_history, { desc = "T Command History"})
vim.keymap.set('n', '<leader>f.', builtin.oldfiles, { desc = 'T Recent files ("." for repeat)'})

vim.keymap.set('n', '<leader>/', function()
  builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>s/', function()
  builtin.live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end, { desc = '[S]earch [/] in Open Files' })

vim.keymap.set('n', '<leader>fn', function()
  builtin.find_files { cwd = vim.fn.stdpath 'config' }
end, { desc = '[S]earch [N]eovim files' })
