local telescope = require('telescope')
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
