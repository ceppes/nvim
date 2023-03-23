local M = {}

M.plugins = {
  "neovim/nvim-lspconfig",
  requires = {
    "williamboman/nvim-lsp-installer",
    "SmiteshP/nvim-navic",
    {'mfussenegger/nvim-jdtls', ft = 'java'},
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'j-hui/fidget.nvim',
  },
  config = function ()
    require('features.lspconfig').setup_servers()
 end
}

function M.highlight()
  vim.cmd([[hi LspDiagnosticsVirtualTextError guifg=red gui=bold,italic,undercurl]])
  vim.cmd([[hi LspDiagnosticsVirtualTextWarning guifg=orange gui=bold,italic,undercurl]])
  vim.cmd([[hi LspDiagnosticsVirtualTextInformation guifg=yellow gui=bold,italic,undercurl]])
  vim.cmd([[hi LspDiagnosticsVirtualTextHint guifg=green gui=bold,italic,undercurl]])
end

function M.commands()
  vim.api.nvim_create_user_command('LspLineOff', 'lua vim.diagnostic.config({ virtual_lines = false, virtual_text = true })', { nargs = 0 })
  vim.api.nvim_create_user_command('LspLineOn', 'lua vim.diagnostic.config({ virtual_lines = true, virtual_text = false })', { nargs = 0 })

  vim.api.nvim_create_user_command('LspTextOff', 'lua vim.diagnostic.config({virtual_text=false})', { nargs = 0 })
  vim.api.nvim_create_user_command('LspTextOn', 'lua vim.diagnostic.config({virtual_text=true})', { nargs = 0 })
end

function M.autocmd()
  -- Show line diagnostics automatically in hover window
  vim.cmd([[
    autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, { focus = false })
  ]])
end

function M.keymaps()
  vim.keymap.set('n', 'gR', require('telescope.builtin').lsp_references, {desc = 'Telescope Lsp References'})
  vim.keymap.set('n', 'gD', require('telescope.builtin').lsp_definitions, {desc = 'Telescope Lsp Definitions'})
end

function M.setup_servers()
  local lsp_status_ok, lspconfig = pcall(require, 'lspconfig')
  if not lsp_status_ok then
    return
  end

  -- little progress bar for lsp loading
  require"fidget".setup{}

  local servers = {
    pyright = require('features.languages.python').lsp(),
    lua_ls = require('features.languages.lua').lsp(),
  }

  for server, config in pairs(servers) do
    if config then
      lspconfig[server].setup(config)
    end
  end
end

return M
