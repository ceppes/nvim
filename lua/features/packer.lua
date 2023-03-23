local M = {}

function M.keymap()
  vim.keymap.set('n', '<leader>ps', require('packer').sync, {desc = 'Packer Sync'})
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
