local M = {}

M = {
  "SmiteshP/nvim-navic",
  dependencies = {
    "neovim/nvim-lspconfig",
    "nvim-tree/nvim-web-devicons", -- optional dependency
    "utilyre/barbecue.nvim",
  },
  config = function()
    require("features.winbar").setup()
  end
}

function M.setup()
  local icons = {
    File          = "󰈙 ",
    Module        = " ",
    Namespace     = "󰌗 ",
    Package       = " ",
    Class         = "󰌗 ",
    Method        = "󰆧 ",
    Property      = " ",
    Field         = " ",
    Constructor   = " ",
    Enum          = "󰕘",
    Interface     = "󰕘",
    Function      = "󰊕 ",
    Variable      = "󰆧 ",
    Constant      = "󰏿 ",
    String        = "󰀬 ",
    Number        = "󰎠 ",
    Boolean       = "◩ ",
    Array         = "󰅪 ",
    Object        = "󰅩 ",
    Key           = "󰌋 ",
    Null          = "󰟢 ",
    EnumMember    = " ",
    Struct        = "󰌗 ",
    Event         = " ",
    Operator      = "󰆕 ",
    TypeParameter = "󰊄 ",
  }

  local navic = require("nvim-navic")
  navic.setup {
      icons = icons,
      lsp = {
          auto_attach = false,
          preference = nil,
      },
      highlight = true,
      separator = "  ",
      depth_limit = 5,
      depth_limit_indicator = "..",
      safe_output = true,
      lazy_update_context = true,
      click = false,
      format_text = function(text)
          return text
      end,
  }
  require("barbecue").setup({
    attach_navic = false, -- prevent barbecue from automatically attaching nvim-navic
    kinds = icons,
    symbols = {
      separator = "",
    }
  })
end


return M
