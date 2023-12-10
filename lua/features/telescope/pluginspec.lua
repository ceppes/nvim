return {
  'nvim-telescope/telescope.nvim',
  dependencies = { 'nvim-lua/plenary.nvim', },
  config = function ()
    require('features.telescope.setup')
    require('features.telescope.keymap')
  end
}
