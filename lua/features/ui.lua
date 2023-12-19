local M = {}

M = {
  {
    'rcarriga/nvim-notify',
    config = function ()
      require("features.ui").setup()
    end,
  },
  {
    'stevearc/dressing.nvim',
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      presets = {
        lsp_doc_border = true
      }
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    }
  }
}

function M.setup()
  require("notify").setup({
    background_colour = "#000000",
    timeout = 8000, --5000 default
  })
  vim.notify = require("notify")
  require("telescope").load_extension("notify")

  require("dressing").setup({})
end

return M
