local function loadPlugins()
  local packer = require 'packer'
  packer.use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
end

local telescope = require('Telescope')

local function setup()
  telescope.setup({
    defaults = {
      layout_strategy = "vertical",
      layout_config = {
        prompt_position = 'top',
        mirror = true,
        preview_height = 0.65
      }
    }
  })
end

local function map(mode, lhs, rhs, opts)
  -- noremap : no recursive mapping
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local function keymaps()
  require'which-key'.register({
    f = {
      name = "Find",
    }
  }, {
    mode = "n",
    prefix = "<leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = false,
  })

  local builtin = require'telescope.builtin'

  vim.keymap.set('n', '<leader>ff', builtin.find_files, {desc = 'T Find files'} )
  vim.keymap.set('n', '<leader>feh', function ()
      builtin.find_files({hidden = true})
    end,
    {desc = 'T Find files with hidden'} )
  vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = "T Git files"})
  vim.keymap.set('n', '<leader>fl', builtin.live_grep, { desc = "T Live grep"})
  vim.keymap.set('n', '<leader>fs', function ()
      builtin.grep_string({ search = vim.fn.input("Grep > ")});
    end,
    {desc = 'T Grep string'})
  vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "T Buffers"})
  map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>')
  map('n', '<leader>fr', '<cmd>Telescope resume<cr>')
  map('n', '<leader>fp', '<cmd>Telescope pickers<cr>')
  map('n', '<leader>fwr', '<cmd>lua require"telescope.builtin".grep_string({search = vim.fn.expand("<cword>")})<cr>')


  -- TODO google telescope.buitlin.grep_string
  -- local options = { noremap = true, silent = true }
  -- vim.keymap.set(
  --   'n',
  --   '<leader>fs',
  --   function ()
  --     local telescope = require('Telescope')
  --     telescope.builtin.grep_string()
  --   end,
  --   options)
end

loadPlugins()
setup()
keymaps()

