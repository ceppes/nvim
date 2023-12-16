local M = {}

M = {
  'jose-elias-alvarez/null-ls.nvim',
  dependencies = {
    "jayp0521/mason-null-ls.nvim",
  },
  config = function ()
    require("features.lint").setup()
  end
}


function M.setup()
  local lint_ensure_installed = {
    'markdownlint',
  }
  local servers = require("features.lspconfig.servers")
  for server, config in pairs(servers) do
    local lint = config.linter
    if lint then
      table.insert(lint_ensure_installed, lint)
    end
  end

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





