local M = {}

M.lsp_key = ""
M.lspbin = ""
M.debugger = ""
M.treesitter = { "" }
M.filetypes = { "" }
M.linter = { "" }
M.formatter = { "" }

vim.api.nvim_create_autocmd("FileType", {
    pattern = M.filetypes,
    callback = function() end,
})

function M.lsp()
    local lsp_status_ok, lspconfig = pcall(require, "lspconfig")
    if not lsp_status_ok then
        return
    end

    return require("features.lsp.server_config").config({
        cmd = {},
        filetypes = M.filetypes,
        root_markers = lspconfig.util.root_pattern(),
    })
end

function M.plugin() end

function M.keymaps()
    vim.keymap.set("n", "<leader>", function() end, { desc = "" })
end

function M.debug()
    local dap_status_ok, dap = pcall(require, "dap")
    if not dap_status_ok then
        return
    end

    dap.adapters.language = {
        type = "executable",
        command = function(config) end,
        args = {},
    }

    dap.configurations.language = {
        {
            name = "",
            type = "language",
            request = "launch",
            program = "",
        },
    }
end

function M.format() end

return M
