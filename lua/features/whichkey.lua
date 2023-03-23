local M = {}

M.plugins = {
  "folke/which-key.nvim",
  config = function()
    require("features.whichkey").setup()
  end
}

function M.setup()
  local whichkey =  require('which-key')
  vim.o.timeout = true
  vim.opt.timeoutlen = 900
  whichkey.setup {}
end

return M
