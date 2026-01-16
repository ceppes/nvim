vim.api.nvim_create_user_command(
    "LspLineOff",
    "lua vim.diagnostic.config({ virtual_lines = false, virtual_text = true })",
    { nargs = 0 }
)
vim.api.nvim_create_user_command(
    "LspLineOn",
    "lua vim.diagnostic.config({ virtual_lines = true, virtual_text = false })",
    { nargs = 0 }
)

vim.api.nvim_create_user_command("LspTextOff", "lua vim.diagnostic.config({virtual_text=false})", { nargs = 0 })
vim.api.nvim_create_user_command("LspTextOn", "lua vim.diagnostic.config({virtual_text=true})", { nargs = 0 })
