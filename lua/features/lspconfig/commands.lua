local lsp_text_enabled = true
vim.api.nvim_create_user_command("ToogleLspText", function()
    lsp_text_enabled = not lsp_text_enabled
    vim.diagnostic.config({ virtual_text = lsp_text_enabled })
    print("LSP virtual text: " .. (lsp_text_enabled and "ON" or "OFF"))
end, { nargs = 0, desc = "Toggle LSP virtual text" })

local lsp_line_enabled = false
vim.api.nvim_create_user_command("ToggleLspLine", function()
    lsp_line_enabled = not lsp_line_enabled
    vim.diagnostic.config({
        virtual_lines = lsp_line_enabled,
        virtual_text = not lsp_line_enabled,
    })
    print("LSP virtual lines: " .. (lsp_line_enabled and "ON" or "OFF"))
end, { nargs = 0, desc = "Toggle LSP virtual lines" })
