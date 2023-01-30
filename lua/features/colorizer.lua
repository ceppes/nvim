local packer = require'packer'
packer.use 'norcalli/nvim-colorizer.lua'

local colorizer_status_ok, colorizer = pcall(require, 'colorizer')
if not colorizer_status_ok then
  return
end

colorizer.setup {
  'css';
  'javascript';
  'html';
  'python';
}
