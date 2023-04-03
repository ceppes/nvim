local M = {}

M.plugins = {
  'norcalli/nvim-colorizer.lua',
  config = function()
    require("features.colorizer").setup()
  end
}

function M.setup()
  local colorizer_status_ok, colorizer = pcall(require, 'colorizer')
  if not colorizer_status_ok then
    return
  end

  colorizer.setup {
    'css';
    'javascript';
    'html';
    'python';
    'lua';
  }
end

return M
