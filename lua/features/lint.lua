local M = {}

M.plugins = {
  'jose-elias-alvarez/null-ls.nvim',
  requires = {
    "jayp0521/mason-null-ls.nvim",
  },
  config = function ()
    require("features.lint").setup()
  end
}

local lint_ensure_installed = {
  'pylint',
  'markdownlint',
  'prettier'
}

function M.setup()
  require('mason-null-ls').setup({ ensure_installed = lint_ensure_installed })

  local null_ls = require("null-ls")
  null_ls.setup({
    sources = {
      null_ls.builtins.diagnostics.pylint,
      null_ls.builtins.diagnostics.hadolint,
    },
  })
end

return M





