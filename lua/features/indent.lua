local M = {}

M.plugins = {
  'lukas-reineke/indent-blankline.nvim',
  config = function()
    require("features.indent").setup()
    require("features.indent").commands()
  end
}

function M.commands()
  vim.api.nvim_create_user_command('CopyModeToggle', function ()
    if M.copyMode then
      vim.opt.listchars:append "space:⋅"
      vim.opt.listchars:append "eol:↴"
      vim.opt.number = true
      require('gitsigns').setup({current_line_blame=true})
      require('indent_blankline').setup({
        show_end_of_line = true,
        space_char_blankline = " ",
        show_current_context_start = true,
        show_trailing_blankline_indent = true,
      })

      M.copyMode = false
    else
      vim.opt.listchars:append "space: "
      vim.opt.listchars:append "eol: "
      vim.opt.number = false
      require('gitsigns').setup({current_line_blame=false})
      require('indent_blankline').setup({
        show_end_of_line = false,
        space_char_blankline = " ",
        show_current_context_start = false,
        show_trailing_blankline_indent = false,
        char = ""
      })

      M.copyMode = true
    end
  end, { nargs = 0, desc = 'Turn on indent signs' })

  vim.api.nvim_create_user_command('CopyModeOff', function ()
    vim.opt.listchars:append "space:⋅"
    vim.opt.listchars:append "eol:↴"
    vim.opt.number = true
    require('gitsigns').setup({current_line_blame=true})
  end, { nargs = 0, desc = 'Turn on indent signs' })

  vim.api.nvim_create_user_command('CopyModeOn', function ()
    vim.opt.listchars:append "space: "
    vim.opt.listchars:append "eol: "
    vim.opt.number = false
    require('gitsigns').setup({current_line_blame=false})
  end, { nargs = 0, desc =  'Turn off indent signs'})
end

-- vim.opt.termguicolors = true
-- vim.cmd [[highlight IndentBlanklineIndent1 guibg=#1f1f1f gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent2 guibg=#1a1a1a gui=nocombine]]

function M.setup()
  local indent_blankline = require 'indent_blankline'
  vim.opt.list = true
  vim.opt.listchars:append "space:⋅"
  vim.opt.listchars:append "eol:↴"

  M.copyMode = false
  indent_blankline.setup{
    show_end_of_line = true,
    space_char_blankline = " ",
    show_current_context_start = true,
    -- char = "",
    --   char_highlight_list = {
    --       "IndentBlanklineIndent1",
    --       "IndentBlanklineIndent2",
    --   },
    --   space_char_highlight_list = {
    --       "IndentBlanklineIndent1",
    --       "IndentBlanklineIndent2",
    --   },
    --   show_trailing_blankline_indent = false,
  }
end

return M
