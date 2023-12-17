local M = {}

M = {
  'numToStr/Comment.nvim',
  lazy = false,
  config = function ()
    require("features.comment").setup()
  end
}

function M.setup()
  require('Comment').setup()
end

return M

