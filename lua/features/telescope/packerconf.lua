return {
  'nvim-telescope/telescope.nvim',
  requires = { {'nvim-lua/plenary.nvim'} },
  config = function ()
    require('features.telescope.setup')
    require('features.telescope.keymap')
  end
}
