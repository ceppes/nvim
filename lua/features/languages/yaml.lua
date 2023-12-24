-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#yamlls

local M = {}

M.lsp_key = 'yamlls'
M.lspbin = "yaml-language-server"
M.treesitter = "yaml"

function M.lsp()
  local lsp_status_ok, lspconfig = pcall(require, 'lspconfig')
  if not lsp_status_ok then
    return
  end

  return require("features.lsp.server_config").config(
    M.lspbin,
    {
      cmd = {"yaml-language-server", "--stdio"},
      filetypes = {"yaml", "yaml.docker-compose", "yml"},
      root_dir = lspconfig.util.root_pattern("*.yaml"),
      settings = {
        yaml = {
          schemaStore = {
            enable = true,
            url = "https://www.schemastore.org/api/json/catalog.json",
          },
          schemas = {
            kubernetes = "/*.y*ml", --globPattern
            ["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json"] = "/*.k8s.yaml",
            ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
            ["https://raw.githubusercontent.com/GoogleContainerTools/skaffold/master/docs/content/en/schemas/v2beta8.json"] = "skaffold.yaml",
            ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
            ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
            ["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = "azure-pipelines.yml",
            ["http://json.schemastore.org/ansible-stable-2.9"] = "tasks/*.{yml,yaml}",
            ["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
            ["http://json.schemastore.org/ansible-playbook"] = "*play*.{yml,yaml}",
            ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
            ["https://json.schemastore.org/dependabot-v2"] = ".github/dependabot.{yml,yaml}",
            ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = "*gitlab-ci*.{yml,yaml}",
            ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "*api*.{yml,yaml}",
            ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",
            ["https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json"] = "*flow*.{yml,yaml}",
          },
          format = {
            enabled = true
          },
          -- anabling this conflicts between Kubernetes resources and kustomization.yaml and Helmreleases
          -- see utils.custom_lsp_attach() for the workaround
          -- how can I detect Kubernetes ONLY yaml files? (no CRDs, Helmreleases, etc.)
          validate = true,
          completion = true,
          hover = true,
          trace = {
            server = "verbose"
          },
          schemaDownload = {
            enable = true
          }
        },
      }
    }
  )
end

return M
