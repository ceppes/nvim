local M = {}

M.plugins = {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function ()
      require('features.trouble').setup()
      require('features.trouble').keymaps()
    end
}


function M.keymaps()
  vim.keymap.set('n', '<leader>xw', '<cmd>TroubleToggle workspace_diagnostics<cr>')
  vim.keymap.set('n', '<leader>xd', '<cmd>TroubleToggle document_diagnostics<cr>')
  vim.keymap.set('n', '<leader>xl', '<cmd>TroubleToggle loclist<cr>')
  vim.keymap.set('n', '<leader>xq', '<cmd>TroubleToggle quickfix<cr>')
  vim.keymap.set('n', '<leader>xr', '<cmd>TroubleToggle lsp_references<cr>')
end

function M.setup()
  require("trouble").setup()
end

return M
