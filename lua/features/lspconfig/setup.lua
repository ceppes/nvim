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
  if config.lsp then
    table.insert(lsp_ensure_installed, server)
  end
end
require("mason-lspconfig").setup{ ensure_installed = lsp_ensure_installed }

require("fidget").setup{} -- little progress bar for lsp loading

