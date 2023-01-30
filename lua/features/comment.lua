local function loadPlugins()
  local packer = require 'packer'
  packer.use 'numToStr/Comment.nvim'
end

local function setup()
  require('Comment').setup()
end

loadPlugins()
setup()
