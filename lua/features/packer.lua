local M = {}

function M.keymap()
  packer = require('packer')
  vim.keymap.set('n', '<leader>ps', packer.sync, {desc = 'Packer Sync'})
end

function M.use(plugins)
  return function(use)
    use({ "wbthomason/packer.nvim", opt = true })
    for _, plugin in ipairs(plugins) do
      use(plugin)
    end
  end
end

return M
