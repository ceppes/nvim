local M = {}

M = {
	"goolord/alpha-nvim",
	event = "VimEnter",
	enabled = true,
	init = false,
	opts = function()
		local header_neovim = {
			"                                                     ",
			"  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
			"  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
			"  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
			"  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
			"  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
			"  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
			"                                                     ",
		}

		local header_terminal = {
			type = "terminal",
			command = vim.fn.expand("$HOME") .. "/.config/nvim/lua/features/thisisfine.sh",
			width = 46,
			height = 25,
			opts = {
				redraw = true,
				window_config = {},
			},
		}

		local dashboard = require("alpha.themes.dashboard")
		dashboard.section.header.val = header_neovim

		dashboard.section.buttons.val = {
			dashboard.button("l", " Load last session current dir", ":SessionManager load_current_dir_session<CR>"),
			dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
			dashboard.button("f f", "  Find File", ":Telescope find_files<CR>"),
			dashboard.button("r", "󰊄  Recently opened files", ":Telescope oldfiles<CR>"),
			dashboard.button("f l", "󰈬  Find Word", ":Telescope live_grep<CR>"),
			dashboard.button("u", "  Open Lazy", ":Lazy<CR>"),
			dashboard.button("q", " Quit", ":qa!<CR>"),
			-- dashboard.button("SPC f r", "  Frecency/MRU"),
			-- dashboard.button("c", "  Configuration", ":e $MYVIMRC<CR>"),
			-- dashboard.button("SPC f m", "  Jump to bookmarks"),
		}

		for _, button in ipairs(dashboard.section.buttons.val) do
			button.opts.hl = "AlphaButtons"
			button.opts.hl_shortcut = "AlphaShortcut"
		end
		dashboard.section.header.opts.hl = "AlphaHeader"
		dashboard.section.buttons.opts.hl = "AlphaButtons"
		dashboard.section.footer.opts.hl = "AlphaFooter"

		dashboard.opts.layout[1].val = 0 -- First padding
		return dashboard
	end,

	config = function(_, dashboard)
		-- close Lazy and re-open when the dashboard is ready
		if vim.o.filetype == "lazy" then
			vim.cmd.close()
			vim.api.nvim_create_autocmd("User", {
				once = true,
				pattern = "AlphaReady",
				callback = function()
					require("lazy").show()
				end,
			})
		end

		require("alpha").setup(dashboard.opts)

		vim.api.nvim_create_autocmd("User", {
			once = true,
			pattern = "LazyVimStarted",
			callback = function()
				local stats = require("lazy").stats()
				local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
				local plugins_count = "⚡ Neovim loaded "
					.. stats.loaded
					.. "/"
					.. stats.count
					.. " plugins in "
					.. ms
					.. "ms"

				local platform = "No OS"
				if vim.fn.has("win32") == 1 then
					platform = " Windows"
				elseif vim.fn.has("mac") == 1 then
					platform = " MacOs"
				elseif vim.fn.has("unix") == 1 then
					platform = " Linux"
				end
				local version = " "
					.. vim.version().major
					.. "."
					.. vim.version().minor
					.. "."
					.. vim.version().patch
				local datetime = os.date(" %d-%m-%Y  %H:%M:%S")

				dashboard.section.footer.val = plugins_count
					.. "\n"
					.. platform
					.. "    "
					.. version
					.. "    "
					.. datetime

				pcall(vim.cmd.AlphaRedraw)
			end,
		})
	end,
}

return M
