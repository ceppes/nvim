local telescope_status_ok, telescope = pcall(require, 'telescope')
if not telescope_status_ok then
  return
end

local config = {}

config = {
  defaults = {
    layout_strategy = "vertical",
    layout_config = {
      vertical ={
        prompt_position = 'top',
        mirror = true,
      }
    }
  }
}

local pickers = {}
pickers = {
  live_grep = {
    layout_strategy = "vertical",
    layout_config = {
      -- anchor = "N",
      preview_height = 0.65,
      height = 0.90,
      width = 0.80,
    },
    prompt_prefix = "   ",
    theme = "dropdown",
  },
  find_files = {
    layout_strategy = "vertical",
    layout_config = {
      preview_height = 0.65,
      height = 0.90,
      width = 0.80,
    },
    prompt_prefix = "   ",
    theme = "dropdown",

  }
}
config.pickers = pickers

config.extensions = {
}

telescope.setup(config)
for extension, _ in pairs(config.extensions) do
  telescope.load_extension(extension)
end
