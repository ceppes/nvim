local M = {}

M.plugins = {
  'jose-elias-alvarez/null-ls.nvim',
  config = function ()
    require("features.lint").setup()
  end
}

function M.setup()
  local null_ls = require("null-ls")
  null_ls.setup({
    sources = {
      null_ls.builtins.diagnostics.pylint,
      null_ls.builtins.diagnostics.hadolint,
    },
  })
end

return M





