--[[
██╗███╗   ██╗██╗████████╗██╗     ██╗   ██╗ █████╗
██║████╗  ██║██║╚══██╔══╝██║     ██║   ██║██╔══██╗
██ ██╔██╗ ██║██║   ██║   ██║     ██║   ██║███████║
██║██║╚██╗██║██║   ██║   ██║     ██║   ██║██╔══██║
██║██║ ╚████║██║   ██║██╗███████╗╚██████╔╝██║  ██║
╚═╝╚═╝  ╚═══╝╚═╝   ╚═╝╚═╝╚══════╝ ╚═════╝ ╚═╝  ╚═╝
--]]

vim.opt.termguicolors = true

-- Undercurl sequences for terminal compatibility
-- vim.cmd([[
--   let &t_Cs = "\e[4:3m"    " start undercurl
--   let &t_Ce = "\e[4:0m"    " end undercurl
-- ]])

require("core.settings")
require("core.keymaps")
require("core.command")
require("core.autocommand")
require("plugin_manager")
