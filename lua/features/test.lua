local M = {}

M = {
}

require'which-key'.register(
{
  tt = { name = "Test", }
},{
  mode = "n",
  prefix = "<leader>",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
})

return M
