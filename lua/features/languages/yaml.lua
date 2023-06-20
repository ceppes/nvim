-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#yamlls
local M = {}

M.lspbin = "yaml-language-server"

function M.lsp()

  return require("features.lsp.server_config").config(
    M.lspbin,
    {
      settings = {
        yaml = {
          schemas = {
            ["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json"] = "/*.k8s.yaml",
          },
        },
      }
    }
  )

end

return M
