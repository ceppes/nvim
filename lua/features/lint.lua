local M = {}

M = {
    {
        "mfussenegger/nvim-lint",
        dependencies = {
            "williamboman/mason.nvim",
        },
        config = function()
            require("features.lint").setup()
        end,
    },
    {
        "rshkarin/mason-nvim-lint",
        dependencies = {
            "williamboman/mason.nvim",
            "rshkarin/mason-nvim-lint",
        },
    },
}

function M.get_active_clients()
    -- Add linters (from nvim-lint)
    local buf_ft = vim.bo.filetype
    local buf_client_names = {}
    local lint_s, lint = pcall(require, "lint")

    if lint_s then
        if lint.get_running() == nil then
            return { "No Lint" }
        end

        for ft_k, ft_v in pairs(lint.linters_by_ft) do
            if type(ft_v) == "table" then
                for _, linter in ipairs(ft_v) do
                    if buf_ft == ft_k then
                        table.insert(buf_client_names, linter)
                    end
                end
            elseif type(ft_v) == "string" then
                if buf_ft == ft_k then
                    table.insert(buf_client_names, ft_v)
                end
            end
        end
    end
    return buf_client_names
end

function M.setup()
    local lint_ensure_installed = {}
    local lint_ft_linter = {}

    local servers = require("features.lspconfig.servers")
    local lint = require("lint")

    for _, config in pairs(servers) do
        if config.linter then
            table.insert(lint_ensure_installed, config.linter)
        end
        if config.linter and config.filetype then
            lint_ft_linter[config.filetype] = { config.linter }

            if config.linter_cmd and not config.linter_cmd:find("/") and lint.linters[config.linter] then
                lint.linters[config.linter].cmd = config.linter_cmd
            end
        end
    end
    -- for k,v in pairs(lint_ft_linter) do
    --   for i,j in pairs(v) do
    --     print(k, v, i, j)
    --   end
    -- end

    -- for i,j in pairs(lint_ensure_installed) do
    --   print(i, j)
    -- end

    lint.linters_by_ft = lint_ft_linter

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
        callback = function()
            require("lint").try_lint()
        end,
    })

    require("mason-nvim-lint").setup({
        ensure_installed = lint_ensure_installed,
        automatic_installation = true,
    })
end

return M
