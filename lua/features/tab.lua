local M = {}

M = {
  'akinsho/bufferline.nvim',
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function ()
    require("features.tab").setup()
    require("features.tab").keymaps()
  end
}

function M.setup()
  local status, bufferline = pcall(require, "bufferline")
  if (not status) then return end

  bufferline.setup({
    options = {
      mode = "tabs",
      separator_style = 'slant',
      always_show_bufferline = true,
      show_buffer_close_icons = false,
      show_close_icon = false,
      color_icons = true
    },
    highlights = {
      separator = {
        fg = '#073642',
        bg = '#002b36',
      },
      separator_selected = {
        fg = '#073642',
      },
      background = {
        fg = '#657b83',
        bg = '#002b36'
      },
      buffer_selected = {
        fg = '#fdf6e3',
        bold = true,
      },
      fill = {
        bg = '#073642'
      }
    },
  })
end

function M.keymaps()
  require("which-key").add({
    { "<leader>t", group = "Tab" },
  })

  vim.keymap.set('n', '<leader>tn', vim.cmd.tabnew, {desc = 'New tab'})
  vim.keymap.set('n', '<leader>tc', vim.cmd.tabclose, {desc = 'Close tab'})
  vim.keymap.set('n', '<Tab>', vim.cmd.BufferLineCycleNext, {desc = 'Next tab'})
  vim.keymap.set('n', '<S-Tab>', vim.cmd.BufferLineCyclePrev, {desc = 'Prev tab'})
end

return M
