----------------------------------------------------------
-- Statusline configuration file
-----------------------------------------------------------


-- Colorscheme
--local colors = require('')




-- Providers
local lsp = require 'feline.providers.lsp'
local vi_mode_utils = require 'feline.providers.vi_mode'


-- Components
local components = {

    -- vi_mode
    vi_mode ={

    }
}

-- Initialize the components table
local components = {
    active = {},
    inactive = {}
}

-- Insert two sections (left and right) for the active statusline
table.insert(components.active, {})
table.insert(components.active, {})
-- Insert two sections (left and right) for the inactive statusline
table.insert(components.inactive, {})
table.insert(components.inactive, {})






-- Start feline
require('feline').setup()
