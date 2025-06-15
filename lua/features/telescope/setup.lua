local telescope_status_ok, telescope = pcall(require, "telescope")
if not telescope_status_ok then
	return
end

local config = {
	defaults = {
		layout_strategy = "vertical",
		layout_config = {
			vertical = {
				prompt_position = "top",
				mirror = true,
			},
		},
	},
}

config.pickers = {
	live_grep = {
		layout_strategy = "vertical",
		layout_config = {
			-- anchor = "N",
			height = 0.90,
			width = 0.80,
			-- if more than 0.5 and theme dropdown, result at the top are hidden
			preview_height = 0.70,
		},
		prompt_prefix = "   ",
		-- theme = "dropdown",
	},
	find_files = {
		layout_strategy = "vertical",
		layout_config = {
			height = 0.90,
			width = 0.80,
			-- if more than 0.5 and theme dropdown, result at the top are hidden
			preview_height = 0.70,
		},
		prompt_prefix = "   ",
		-- theme = "dropdown",
	},
}

config.extensions = {
	["fzf"] = {},
	["ui-select"] = {
		require("telescope.themes").get_dropdown(),
	},
}

telescope.setup(config)
for extension, _ in pairs(config.extensions) do
	telescope.load_extension(extension)
end
