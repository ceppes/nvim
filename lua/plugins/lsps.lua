local lsp_status_ok, lspconfig = pcall(require, 'lspconfig')
if not lsp_status_ok then
  return
end

local cmp_status_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not cmp_status_ok then
  return
end

local cmd = vim.cmd

require("nvim-lsp-installer").setup {}


-- vim.lsp.handlers["textDocument/publishDiagnostics"] =
--   vim.lsp.with(
--   vim.lsp.diagnostic.on_publish_diagnostics,
vim.diagnostic.config({
    underline = true,
    -- Enable virtual text, override spacing to 4
    -- virtual_text = {
    --   spacing = 4,
    --   severity_linit = "Warning"
    -- },

    -- Diagnostic options, see: `:help vim.diagnostic.config`
    virtual_text = false,
    signs = true,
    update_in_insert = true
  }
)

-- vim.fn.sign_define("LspDiagnosticsSignError", {text = "", numhl = "LspDiagnosticsDefaultError"})
-- vim.fn.sign_define("LspDiagnosticsSignWarning", {text = "", numhl = "LspDiagnosticsDefaultWarning"})
-- vim.fn.sign_define("LspDiagnosticsSignInformation", {text = "", numhl = "LspDiagnosticsDefaultInformation"})
-- vim.fn.sign_define("LspDiagnosticsSignHint", {text = "", numhl = "LspDiagnosticsDefaultHint"})

cmd([[hi LspDiagnosticsVirtualTextError guifg=red gui=bold,italic,underline]])
cmd([[hi LspDiagnosticsVirtualTextWarning guifg=orange gui=bold,italic,underline]])
cmd([[hi LspDiagnosticsVirtualTextInformation guifg=yellow gui=bold,italic,underline]])
cmd([[hi LspDiagnosticsVirtualTextHint guifg=green gui=bold,italic,underline]])

-- hi LspDiagnosticsVirtualTextError guifg=red gui=bold,italic,underline
-- hi LspDiagnosticsVirtualTextWarning guifg=orange gui=bold,italic,underline
-- hi LspDiagnosticsVirtualTextInformation guifg=yellow gui=bold,italic,underline
-- hi LspDiagnosticsVirtualTextHint guifg=green gui=bold,italic,underline

require("lsp_lines").setup()
-- Show line diagnostics automatically in hover window
cmd([[
  autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, { focus = false })
]])

-- Add additional capabilities supported by nvim-cmp
-- See: https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

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
  local opts = { noremap=true, silent=true }

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<space>ftt', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>d', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
--buf_set_keymap('n', '<space>d', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '<space>ld', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
--buf_set_keymap('n', '<space>ld', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
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

