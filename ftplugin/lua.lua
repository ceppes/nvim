require'lspconfig'.sumneko_lua.setup {
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
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}


-- config lua
-- doesn't work
-- dap.configurations.lua = {
--   {
--     type = "nlua",
--     request = "attach",
--     name = "Attach to running Neovim instance",
--     host = function()
--       local value = vim.fn.input "Host [127.0.0.1]: "
--       if value ~= "" then
--         return value
--       end
--       return "127.0.0.1"
--     end,
--     port = function()
--       local val = tonumber(vim.fn.input("Port: ", "54321"))
--       assert(val, "Please provide a port number")
--       return val
--     end,
--   },
-- }
-- dap.adapters.nlua = function(callback, config)
--   callback { type = "server", host = config.host, port = config.port }
-- end
