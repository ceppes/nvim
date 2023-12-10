local M = {}

M = {
    'rcarriga/nvim-notify',
    config = function ()
      require("features.notify").setup()
    end,
}

function M.setup()
  require("notify").setup({
    background_colour = "#000000",
  })
  vim.notify = require("notify")
  require("telescope").load_extension("notify")
end

return M
