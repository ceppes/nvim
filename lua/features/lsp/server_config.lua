local M = {}

function M.config(bin, opts)

  if vim.fn.executable(bin) ~= 1 then
    vim.notify("[Server config] Executable check failed for " .. bin)
    return false
  end
  vim.notify("[Server config] Executable success for " .. bin)


  local config = {
    capabilities = require("features.lsp.capabilities"),
    handler = require("features.lsp.handler").hover,
    on_attach = function(client, bufnr)
      require("features.lsp.attach").attach(client, bufnr)
    end
  }

  return config
end

return M

