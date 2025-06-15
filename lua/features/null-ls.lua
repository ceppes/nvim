local M = {}

M = {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = {
        "jayp0521/mason-null-ls.nvim",
    },
    config = function()
        require("features.null-ls").setup()
    end,
}

function M.get_active_clients()
    -- Generally, you should use either null-ls or nvim-lint + formatter.nvim, not both.
    -- Add sources (from null-ls)
    -- null-ls registers each source as a separate attached client, so we need to filter for unique names down below.
    local buf_ft = vim.bo.filetype
    local buf_client_names = {}
    local null_ls_s, null_ls = pcall(require, "null-ls")
    if null_ls_s then
        local sources = null_ls.get_sources()

        if #sources == 0 then
            return { "Null-ls inactive" }
        end

        for _, source in ipairs(sources) do
            if source._validated then
                for ft_name, ft_active in pairs(source.filetypes) do
                    if ft_name == buf_ft and ft_active then
                        table.insert(buf_client_names, source.name)
                    end
                end
            end
        end
    end
    return buf_client_names
end

function M.setup()
    local lint_ensure_installed = {}

    local servers = require("features.lspconfig.servers")
    for _, config in pairs(servers) do
        if config.linter then
            local linter = config.linter
            table.insert(lint_ensure_installed, linter)
        end
    end

    require("mason-null-ls").setup({ ensure_installed = lint_ensure_installed })

    local null_ls = require("null-ls")

    local code_actions = null_ls.builtins.code_actions
    local diagnostics = null_ls.builtins.diagnostics
    local formatting = null_ls.builtins.formatting

    null_ls.setup({
        sources = {
            diagnostics.hadolint,
            formatting.black,
            formatting.stylua,
        },
    })
end

return M
