local M = {}

M.lsp_key = "rust_analyzer"
M.lspbin = "rust-analyzer"
M.debugger = "codelldb"
M.treesitter = { "rust" }
M.filetypes = { "rust" }
-- M.linter = { "clippy" }
M.formatter = { "rustfmt" }

vim.api.nvim_create_autocmd("FileType", {
    pattern = M.filetypes,
    callback = function()
        vim.bo.shiftwidth = 4
        vim.bo.tabstop = 4
        vim.opt_local.expandtab = true
        vim.opt_local.textwidth = 100
        M.keymaps()
    end,
})

function M.keymaps()
    if vim.bo.filetype == "rust" then
        vim.keymap.set("n", "<leader>rr", "<cmd>RustRun<CR>", { desc = "Run Rust" })
        vim.keymap.set("n", "<leader>rt", "<cmd>RustTest<CR>", { desc = "Test Rust" })
        vim.keymap.set("n", "<leader>rc", "<cmd>RustOpenCargo<CR>", { desc = "Open Cargo.toml" })
        vim.keymap.set("n", "<leader>rh", "<cmd>RustHoverActions<CR>", { desc = "Hover Actions" })
        vim.keymap.set("n", "<leader>rd", "<cmd>RustDebuggables<CR>", { desc = "Debuggables" })
    end
end

function M.lsp()
    local lsp_status_ok, lspconfig = pcall(require, "lspconfig")
    if not lsp_status_ok then
        return
    end

    local rust_root_files = {
        "Cargo.toml",
        "Cargo.lock",
        "rust-project.json",
        ".git",
    }

    return require("features.lsp.server_config").config({
        cmd = { "rust-analyzer" },
        filetypes = M.filetypes,
        root_dir = lspconfig.util.root_pattern(unpack(rust_root_files)),
        settings = {
            ["rust-analyzer"] = {
                cargo = {
                    allFeatures = true,
                    loadOutDirsFromCheck = true,
                    runBuildScripts = true,
                },
                checkOnSave = {
                    allFeatures = true,
                    command = "clippy",
                    extraArgs = { "--no-deps" },
                },
                procMacro = {
                    enable = true,
                    ignored = {
                        ["async-trait"] = { "async_trait" },
                        ["napi-derive"] = { "napi" },
                        ["async-recursion"] = { "async_recursion" },
                    },
                },
            },
        },
    })
end

return M
