local protocol = require("vim.lsp.protocol")
protocol.CompletionItemKind = {
  '', -- Text
  '', -- Method
  '', -- Function
  '', -- Constructor
  '', -- Field
  '', -- Variable
  '', -- Class
  'ﰮ', -- Interface
  '', -- Module
  '', -- Property
  '', -- Unit
  '', -- Value
  '', -- Enum
  '', -- Keyword
  '﬌', -- Snippet
  '', -- Color
  '', -- File
  '', -- Reference
  '', -- Folder
  '', -- EnumMember
  '', -- Constant
  '', -- Struct
  '', -- Event
  'ﬦ', -- Operator
  '', -- TypeParameter
}

require('mason').setup({ ui = { border = 'rounded' } })

local lsp_ensure_installed = {}

local servers = require("features.lspconfig.servers")
for server, config in pairs(servers) do
  if config.lsp and config.lsp_key then
    table.insert(lsp_ensure_installed, config.lsp_key)
  end
end
require("mason-lspconfig").setup{
  ensure_installed = lsp_ensure_installed,
  handlers = {
    function(server_name)
      local server = servers[server_name] or {}
      -- This handles overriding only values explicitly passed
      -- by the server configuration above. Useful when disabling
      -- certain features of an LSP (for example, turning off formatting for ts_ls)
      server.capabilities = vim.tbl_deep_extend('force', {}, require("features.lsp.capabilities"), server.capabilities or {})
      require('lspconfig')[server_name].setup(server)
    end,
  }
}
