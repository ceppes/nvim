local M = {}

function M.config(bin, opts)

  if vim.fn.executable(bin) ~= 1 then
    vim.notify("[LSP][Server config] bin ❌ " .. bin .. " ")
    return false
  end
  vim.notify("[LSP][Server config] bin ✅ " .. bin .. " ")

  local config = {
    capabilities = require("features.lsp.capabilities"),
    handler = require("features.lsp.handler"),
    on_attach = function(client, bufnr)
      require("features.lsp.attach").attach(client, bufnr)
    end
  }

  if opts then
    for key, value in pairs(opts) do
      config[key] = value
    end
  end

  return config
end

return M

