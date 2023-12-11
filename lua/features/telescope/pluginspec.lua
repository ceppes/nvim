return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.5',
  dependencies = { 'nvim-lua/plenary.nvim', },
  config = function ()
    require('features.telescope.setup')
    require('features.telescope.keymap')
  end
}
