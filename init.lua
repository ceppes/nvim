--[[
██╗███╗   ██╗██╗████████╗██╗     ██╗   ██╗ █████╗
██║████╗  ██║██║╚══██╔══╝██║     ██║   ██║██╔══██╗
██ ██╔██╗ ██║██║   ██║   ██║     ██║   ██║███████║
██║██║╚██╗██║██║   ██║   ██║     ██║   ██║██╔══██║
██║██║ ╚████║██║   ██║██╗███████╗╚██████╔╝██║  ██║
╚═╝╚═╝  ╚═══╝╚═╝   ╚═╝╚═╝╚══════╝ ╚═════╝ ╚═╝  ╚═╝
--]]

require('core.settings')
require('core.keymaps')
require('packer_init')
require('features.telescope')
require('core.colors')
require('features.git')
require('features.statusline')
require('features.completion')
require('features.treesitter')
require('features.comment')
require('features.whichkey')
require('features.indent')
require('features.colorizer')
require('features.structure')
require('features.tab')
require('features.trouble')
require('features.debugger')
require('features.welcome')
require('features.lsp')
require('features.lint')
require('features.languages')
-- require('features.languages.python')
require('features.languages.lua')
require('features.languages.yaml')
require('features.undotree')
