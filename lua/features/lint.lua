local M = {}

M = {
    {
        "mfussenegger/nvim-lint",
        event = { "BufWritePre" },
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
    local buf_ft = vim.bo.filetype
    local buf_client_names = {}

    local lint_s, lint = pcall(require, "lint")
    if not lint_s then
        vim.notify("Failed to load the 'lint' module. Linting will not be available.", vim.log.levels.ERROR)
        return
    end

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
    return buf_client_names
end

function M.setup()
    local linter_by_ft = {}

    local servers = require("features.lspconfig.servers")
    local lint = require("lint")

    for _, config in pairs(servers) do
        -- Check if linter and filetype definitions exist in the config
        if config.linter and config.filetypes then
            -- Ensure linter is encapsulated in a table
            local linters = type(config.linter) == "table" and config.linter or { config.linter }

            -- Process filetype list, assuming it can be a single string or a table of filetypes
            local filetypes = type(config.filetypes) == "table" and config.filetypes or { config.filetypes }

            for _, filetype in ipairs(filetypes) do
                -- Initialize linter list for the filetype if it doesn't exist
                if not linter_by_ft[filetype] then
                    linter_by_ft[filetype] = {}
                end

                -- Add unique linters for each filetype
                for _, linter in ipairs(linters) do
                    if not vim.tbl_contains(linter_by_ft[filetype], linter) then
                        table.insert(linter_by_ft[filetype], linter)
                    end

                    -- Optionally, configure the linter command if necessary
                    if config.linter_cmd and lint.linters[linter] then
                        lint.linters[linter].cmd = config.linter_cmd
                    end

                    -- Configure linter args if provided
                    if config.linter_args and lint.linters[linter] then
                        local base_args = lint.linters[linter].args or {}
                        local custom_args = type(config.linter_args) == "function" and config.linter_args() or config.linter_args

                        -- Prepend custom args to base args
                        lint.linters[linter].args = function()
                            local args = vim.list_extend(vim.deepcopy(custom_args), type(base_args) == "function" and base_args() or base_args)
                            return args
                        end
                    end
                end
            end
        end
    end

    -- vim.print(linter_by_ft)

    lint.linters_by_ft = linter_by_ft

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
        callback = function()
            require("lint").try_lint()
        end,
    })

    require("mason-nvim-lint").setup({
        automatic_installation = true,
    })
end

function M.ensure_installed()
    local lint_ensure_installed = {}
    local lint_ensure_installed_unique = {}

    local servers = require("features.lspconfig.servers")

    for _, config in pairs(servers) do
        if config.linter then
            if type(config.linter) == "table" then
                for _, linter in ipairs(config.linter) do
                    lint_ensure_installed_unique[linter] = true
                end
            else
                lint_ensure_installed_unique[config.linter] = true
            end
        end
    end

    for linter, _ in pairs(lint_ensure_installed_unique) do
        table.insert(lint_ensure_installed, linter)
    end

    return lint_ensure_installed
end

return M
