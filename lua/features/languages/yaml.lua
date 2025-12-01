-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#yamlls

local M = {}

M.lsp_key = "yamlls"
M.lspbin = "yaml-language-server"
M.treesitter = "yaml"
M.linter = "yamllint"
M.filetypes = { "yaml", "yml", "helm" }

vim.api.nvim_create_autocmd("FileType", {
    pattern = M.filetypes,
    callback = function()
        vim.bo.shiftwidth = 2
        vim.bo.tabstop = 2
        vim.opt_local.foldmethod = "indent"
        vim.opt_local.expandtab = true
        vim.opt_local.tabstop = 2 -- 1 tab == 2 spaces
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = M.filetypes,
    group = vim.api.nvim_create_augroup("FixYamlCommentString", { clear = true }),
    callback = function()
        vim.bo.commentstring = "# %s"
        require("Comment.ft")(M.filetypes, "# %s")
    end,
})

function M.lsp()
    local lsp_status_ok, lspconfig = pcall(require, "lspconfig")
    if not lsp_status_ok then
        return
    end

    return require("features.lsp.server_config").config({
        cmd = { "yaml-language-server", "--stdio" },
        filetypes = { "yaml", "yaml.docker-compose", "yml" },
        root_markers = { "*.yaml", ".git" },
        settings = {
            yaml = {
                schemaStore = {
                    enable = true,
                    url = "https://www.schemastore.org/api/json/catalog.json",
                },
                schemas = {
                    -- Ansible schemas (most specific patterns first)
                    ["https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/ansible.json#/$defs/playbook"] = {
                        "playbook*.{yml,yaml}",
                        "*playbook.{yml,yaml}",
                        "site.{yml,yaml}",
                    },
                    ["https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/ansible.json#/$defs/tasks"] = {
                        "tasks/*.{yml,yaml}",
                        "handlers/*.{yml,yaml}",
                    },
                    ["https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/requirements.json"] = {
                        "requirements.{yml,yaml}",
                        "roles/requirements.{yml,yaml}",
                        "collections/requirements.{yml,yaml}",
                    },
                    ["https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/meta.json"] = {
                        "meta/main.{yml,yaml}",
                        "*/meta/main.{yml,yaml}",
                    },
                    ["https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/vars.json"] = {
                        "vars/*.{yml,yaml}",
                        "defaults/*.{yml,yaml}",
                        "group_vars/*.{yml,yaml}",
                        "host_vars/*.{yml,yaml}",
                    },

                    -- Kubernetes & Cloud Native
                    ["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json"] = {
                        "k3s/**/*.{yml,yaml}",
                        "k8s/**/*.{yml,yaml}",
                    },
                    ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
                    ["https://raw.githubusercontent.com/GoogleContainerTools/skaffold/master/docs/content/en/schemas/v2beta8.json"] = "skaffold.yaml",
                    ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",

                    -- CI/CD
                    ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
                    ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
                    ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = "*gitlab-ci*.{yml,yaml}",
                    ["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = "azure-pipelines.yml",
                    ["https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json"] = "*flow*.{yml,yaml}",

                    -- Docker & Container
                    ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",

                    -- Other
                    ["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
                    ["https://json.schemastore.org/dependabot-v2"] = ".github/dependabot.{yml,yaml}",
                    ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "*api*.{yml,yaml}",

                    -- Fallback to Kubernetes for generic yaml files (commented out to avoid conflicts)
                    -- kubernetes = "/*.y*ml",
                },
                format = {
                    enabled = true,
                },
                -- anabling this conflicts between Kubernetes resources and kustomization.yaml and Helmreleases
                -- see utils.custom_lsp_attach() for the workaround
                -- how can I detect Kubernetes ONLY yaml files? (no CRDs, Helmreleases, etc.)
                validate = true,
                completion = true,
                hover = true,
                trace = {
                    server = "verbose",
                },
                schemaDownload = {
                    enable = true,
                },
            },
        },
    })
end

return M
