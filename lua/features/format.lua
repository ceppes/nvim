local M = {}

M = {
    "stevearc/conform.nvim",
    config = function()
        require("features.format").setup()
        require("features.format").keymaps()
        require("features.format").command()
    end,
}

function M.get_active_clients()
    local buf_client_names = {}

    local conform_s, conform = pcall(require, "conform")
    if not conform_s then
        vim.notify("Failed to load the 'conform' module. Formatter will not be available.", vim.log.levels.ERROR)
        return
    end

    local l_fo = conform.list_formatters()
    if #l_fo == 0 then
        return { "No FMT" }
    end

    for _, j in ipairs(l_fo) do
        table.insert(buf_client_names, j.command)
    end
    -- vim.print(buf_client_names)

    return buf_client_names
end

function M.keymaps()
    vim.keymap.set("n", "<leader>bf", ":Format<CR>", { desc = "[B]uffer [F]ormat" })
end

function M.setup()
    local format_ensure_installed = {}
    local format_ensure_installed_unique = {}
    local format_by_ft = {}

    local servers = require("features.lspconfig.servers")

    for _, config in pairs(servers) do
        if config.formatter then
            if type(config.formatter) == "table" then
                for _, formatter in ipairs(config.formatter) do
                    format_ensure_installed_unique[formatter] = true
                end
            else
                format_ensure_installed_unique[config.formatter] = true
            end
        end

        -- Check if linter and filetype definitions exist in the config
        if config.formatter and config.filetypes then
            -- Ensure linter is encapsulated in a table
            local formatters = type(config.formatter) == "table" and config.formatter or { config.formatter }

            -- Process filetype list, assuming it can be a single string or a table of filetypes
            local filetypes = type(config.filetypes) == "table" and config.filetypes or { config.filetypes }

            for _, filetype in ipairs(filetypes) do
                -- Initialize linter list for the filetype if it doesn't exist
                if not format_by_ft[filetype] then
                    format_by_ft[filetype] = {}
                end

                -- Add unique linters for each filetype
                for _, formatter in ipairs(formatters) do
                    if not vim.tbl_contains(format_by_ft[filetype], formatter) then
                        table.insert(format_by_ft[filetype], formatter)
                    end
                end
            end
        end

        if type(config.format) == "function" and config.formatter then
            config.format()
        end
    end

    for formatter, _ in pairs(format_ensure_installed_unique) do
        table.insert(format_ensure_installed, formatter)
    end

    table.insert(format_by_ft, {
        -- Use the "*" filetype to run formatters on all filetypes.
        ["*"] = { "codespell" },
        -- Use the "_" filetype to run formatters on filetypes that don't
        -- have other formatters configured.
        ["_"] = { "trim_whitespace" },
    })

    -- vim.print(format_by_ft)
    -- vim.print(format_ensure_installed)

    require("conform").setup({
        formatters_by_ft = format_by_ft,
        format_on_save = {
            -- These options will be passed to conform.format()
            timeout_ms = 500,
            lsp_format = "fallback",
        },
    })

    vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        callback = function(args)
            require("conform").format({ bufnr = args.buf })
        end,
    })

    --
    -- require("mason-nvim-lint").setup({
    --     ensure_installed = format_ensure_installed_unique,
    --     automatic_installation = true,
    -- })
end

function M.command()
    vim.api.nvim_create_user_command("FormatInfo", function()
        vim.print(require("conform").list_all_formatters())
    end, { nargs = 0, desc = "Formatter info" })
end

return M
