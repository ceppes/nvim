local telescope_status_ok, telescope = pcall(require, 'telescope')
if not telescope_status_ok then
  return
end

local config = {}

config = {
  defaults = {
    layout_strategy = "vertical",
    layout_config = {
      prompt_position = 'top',
      mirror = true,
      -- preview_height = 0.65
    }
  }
}

local pickers = {}
pickers.live_grep = {
  layout_config = {
    anchor = "N",
    height = 0.35,
    mirror = true,
    width = 0.55,
  },
  prompt_prefix = "   ",
  theme = "dropdown",
}
config.pickers = pickers

config.extensions = {
}

telescope.setup(config)
for extension, _ in pairs(config.extensions) do
  telescope.load_extension(extension)
end
