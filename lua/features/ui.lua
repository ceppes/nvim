local M = {}

M = {
  'stevearc/dressing.nvim',
  config = function ()
    require("features.ui").setup()
  end
}

function M.setup()
  require("dressing").setup({})
end

return M
