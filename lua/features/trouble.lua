local M = {}

M = {
    "folke/trouble.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function ()
      require('features.trouble').setup()
      require('features.trouble').keymaps()
    end
}

function M.keymaps()
  vim.keymap.set('n', '<leader>xw', '<cmd>Trouble diagnostics<cr>')
  vim.keymap.set('n', '<leader>xd', '<cmd>Trouble document_diagnostics<cr>')
  vim.keymap.set('n', '<leader>xl', '<cmd>Trouble loclist<cr>')
  vim.keymap.set('n', '<leader>xq', '<cmd>Trouble quickfix<cr>')
  vim.keymap.set('n', '<leader>xr', '<cmd>Trouble lsp_references<cr>')
end

function M.setup()
  require("trouble").setup()
end

return M
