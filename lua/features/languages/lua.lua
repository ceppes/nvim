local M = {}

M.lspbin = 'lua-language-server'
M.treesitter = 'lua'
M.lsp_key = 'lua_ls'
M.formatter = 'stylua'

function M.lsp()
  return require("features.lsp.server_config").config(
  M.lspbin,
  {
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = {'vim'},
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("lua", true),
          preloadFileSize = 1000,
          checkThirdParty = false
        },
        completion = {
          callSnippet = "Replace",
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = { enable = false,},
        format = { enable = false },
        hint = { enable = true, setType = true },
      },
    },
  })

end




return M
