local M = {}

M.plugins = {
  'numToStr/Comment.nvim',
  config = function ()
    require("features.comment").setup()
  end
}

function M.setup()
  require('Comment').setup()
end

return M

