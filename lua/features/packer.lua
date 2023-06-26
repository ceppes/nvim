local M = {}

function M.keymap()
  packer = require('packer')
  vim.keymap.set('n', '<leader>ps', packer.sync, {desc = 'Packer Sync'})
  vim.keymap.set('n', '<leader>psp', "<cmd>PackerSync --preview <cr>", {desc = 'Packer Sync Preview'})
-- :PackerSnapshot snapshot-main
-- :PackerSnapshotRollback snapshot-main

-- 1 : packer sync preview
-- 2 : packer sync
-- if fail
-- 3 : packer snapshot rollback snapshot-main
-- if not :
-- 4 : packer snapshot snapshot-main

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
