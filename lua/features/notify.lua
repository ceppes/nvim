local M = {}

M.plugins = {
    'rcarriga/nvim-notify',
    config = function ()
      require("features.notify").setup()
    end,
}

function M.setup()
  require("notify").setup{}
  vim.notify = require("notify")
  require("telescope").load_extension("notify")
end

return M
