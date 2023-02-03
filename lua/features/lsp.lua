local packer = require 'packer'
packer.use "williamboman/nvim-lsp-installer"
packer.use "neovim/nvim-lspconfig"
packer.use "SmiteshP/nvim-navic"
packer.use {'mfussenegger/nvim-jdtls', ft = 'java'}
packer.use 'williamboman/mason.nvim'
packer.use 'williamboman/mason-lspconfig.nvim'

local lsp_status_ok, lspconfig = pcall(require, 'lspconfig')
if not lsp_status_ok then
  return
end

local cmp_status_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not cmp_status_ok then
  return
end

local lsp_installer_status_ok, lsp_installer = pcall(require, 'nvim-lsp-installer')
if not lsp_installer_status_ok then
  return
end

local navic = require("nvim-navic")

local cmd = vim.cmd

lsp_installer.setup({
  ensure_installed = {
    'bashls',
    'jdtls',
    'jsonls',
    'pyright',
    'sumneko_lua',
    'yamlls',
  },
  automatic_installation = true,
})

local function set_sign(type, icon)
  local sign = string.format('DiagnosticSign%s', type)
  local texthl = string.format('DiagnosticDefault%s', type)
  vim.fn.sign_define(sign, { text = icon, texthl = sign, numhl=sign })
end

set_sign('Hint', '')
set_sign('Info', '')
set_sign('Warn', '')
set_sign('Error', '')

vim.lsp.set_log_level('error')


-- vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
-- vim.lsp.handlers["textDocument/publishDiagnostics"] =
--   vim.lsp.with(
--   vim.lsp.diagnostic.on_publish_diagnostics,
vim.diagnostic.config({
    underline = {
      severity_limit = 'Warning'
    },
    virtual_text = {
      prefix = '●',
      spacing = 2, --4
      severity_linit = "Warning"
    },
    signs = {
      severity_limit = 'Warning'
    },
    update_in_insert = true,
    virtual_lines = false
  }
)


cmd([[hi LspDiagnosticsVirtualTextError guifg=red gui=bold,italic,undercurl]])
cmd([[hi LspDiagnosticsVirtualTextWarning guifg=orange gui=bold,italic,undercurl]])
cmd([[hi LspDiagnosticsVirtualTextInformation guifg=yellow gui=bold,italic,undercurl]])
cmd([[hi LspDiagnosticsVirtualTextHint guifg=green gui=bold,italic,undercurl]])

require("lsp_lines").setup()
vim.api.nvim_create_user_command('LspLineOff', 'lua vim.diagnostic.config({ virtual_lines = false, virtual_text = true })', { nargs = 0 })
vim.api.nvim_create_user_command('LspLineOn', 'lua vim.diagnostic.config({ virtual_lines = true, virtual_text = false })', { nargs = 0 })

vim.api.nvim_create_user_command('LspTextOff', 'lua vim.diagnostic.config({virtual_text=false})', { nargs = 0 })
vim.api.nvim_create_user_command('LspTextOn', 'lua vim.diagnostic.config({virtual_text=true})', { nargs = 0 })

-- Show line diagnostics automatically in hover window
cmd([[
  autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, { focus = false })
]])

-- Add additional capabilities supported by nvim-cmp
-- See: https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

capabilities.textDocument.completion.completionItem.documentationFormat = { 'markdown', 'plaintext' }
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  },
}

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local function optiones(options)
      local default_options = { noremap=true, silent=true, buffer = bufnr, remap = false}
      return vim.tbl_extend('force', default_options, options)
  end

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.keymap.set('n', 'gD', function() vim.lsp.buf.declaration() end, optiones({desc = 'LSP Go declaration'}))
  vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, optiones({desc = 'LSP Go definition'}))
  vim.keymap.set('n', 'gi', function() vim.lsp.buf.implementation() end, optiones({desc = 'LSP Implementation'}))
  vim.keymap.set('n', 'gr', function() vim.lsp.buf.references() end, optiones({desc = 'LSP References'}))
  vim.keymap.set('n', '<leader>rn', function() vim.lsp.buf.rename() end, optiones({desc = 'LSP Rename'}))
  vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, optiones({desc = 'LSP Hover'}))
  vim.keymap.set('n', '<C-k>', function() vim.lsp.buf.signature_help() end, optiones({desc = 'LSP Signature help'}))
  vim.keymap.set('n', '<leader>vd', function() vim.lsp.buf.open_float() end, optiones({desc = 'LSP Open float'}))

  vim.keymap.set('n', '<leader>vws', function() vim.lsp.buf.workspace_symbol() end, optiones({desc = 'LSP Workspace symbol'}))
  vim.keymap.set('n', '<leader>wa', function() vim.lsp.buf.add_workspace_folder() end, optiones({desc = 'LSP Add workspace symbol'}))
  vim.keymap.set('n', '<leader>wr', function() vim.lsp.buf.remove_workspace_folder() end, optiones({desc = 'LSP Remove workspace symbol'}))
  vim.keymap.set('n', '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, optiones({desc = 'LSP List workspace folders'}))
  -- vim.keymap.set('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.keymap.set('n', '<leader>ca', function() vim.lsp.buf.code_action() end, optiones({desc = 'LSP Code action'}))
  vim.keymap.set('n', '<leader>ftt', function() vim.lsp.buf.formatting() end, optiones({desc = 'LSP Format'}))

  vim.keymap.set('n', '[d', function() vim.lsp.diagnostic.goto_prev() end, optiones({desc = 'LSP Goto prev'}))
  vim.keymap.set('n', ']d', function() vim.lsp.diagnostic.goto_next() end, optiones({desc = 'LSP Goto next'}))
  -- vim.keymap.set('n', '<space>d', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  vim.keymap.set('n', '<leader>ld', function() vim.lsp.diagnostic.set_loclist() end, optiones({desc = 'LSP Loc list'}))

  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {'jdtls'}
for _, lsp in pairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    root_dir = lspconfig.util.root_pattern('.git'),
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
    },
  }
end
-- local servers = { 'jsonls' }
-- for _, lsp in pairs(servers) do
--   lspconfig[lsp].setup {
--     on_attach = on_attach,
--     capabilities = capabilities,
--     -- root_dir = lspconfig.util.root_pattern('.git'),
--     flags = {
--       -- This will be the default in neovim 0.7+
--       debounce_text_changes = 150,
--     },
--   }
-- end

-- json
lspconfig.jsonls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    -- This will be the default in neovim 0.7+
    debounce_text_changes = 150,
  },
  commands = {
    Format = {
      function()
        vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
      end
    }
  }
}

-- python
local python_root_files = {
  'WORKSPACE',
  'pyproject.toml',
  'setup.py',
  'setup.cfg',
  'requirements.txt',
  'Pipfile',
  'pyrightconfig.json',
  '.git'
}
lspconfig.pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  root_dir = lspconfig.util.root_pattern(unpack(python_root_files)),
  flags = {
    -- This will be the default in neovim 0.7+
    debounce_text_changes = 150,
  },
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "workspace",
        -- diagnosticMode = "openFilesOnly",
        useLibraryCodeForTypes = true,
        -- extraPaths = {lspconfig.util.root_pattern('src')}
      }
    }
  }
}


vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
})

-- little progress bar for lsp loading
require"fidget".setup{}

vim.keymap.set('n', 'gR', require('telescope.builtin').lsp_references, {desc = 'Telescope Lsp References'})
vim.keymap.set('n', 'gD', require('telescope.builtin').lsp_definitions, {desc = 'Telescope Lsp Definitions'})


require("mason").setup()
