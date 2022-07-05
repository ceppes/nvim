
-----------------------------------------------------------
-- Neovim API aliases
-----------------------------------------------------------
local cmd = vim.cmd		      -- Execute Vim commands

-----------------------------------------------------------
-- Lsp
-----------------------------------------------------------
--local nvim_lsp = require 'lspconfig'


--nvim_lsp['pyright'].setup{
    --root_dir = nvim_lsp.util.root_pattern('.git')
--}

--local server = 'pyright'

--server.setup{
--}

-----------------------------------------------------------
-- Linting
-----------------------------------------------------------

local lint = require 'lint'

lint.linters_by_ft = {
  python = {'pylint'}
}

-- cmd [[autocmd BufWritePost <buffer> lua require('lint').try_lint()]]
cmd([[
au BufEnter * lua require('lint').try_lint()
au BufWritePost * lua require('lint').try_lint()
]])

