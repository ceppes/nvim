local function optiones(options)
  local default_options = { noremap=true, silent=true, buffer = bufnr, remap = false}
  return vim.tbl_extend('force', default_options, options)
end

local M = {}

function M.attach(client, bufnr)
  M.keymaps()
  M.diagnostic_keymaps()
  require("features.lsp.diagnostics").setup()

  vim.api.nvim_buf_set_var(bufnr, "lsp_attached", true)

  local navic = require("nvim-navic")
  vim.opt.winbar = "%f > %{%v:lua.require'nvim-navic'.get_location()%}"
end

function M.keymaps()
  vim.keymap.set('n', 'gD', function() vim.lsp.buf.declaration() end, optiones({desc = 'LSP Go declaration'}))
  vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, optiones({desc = 'LSP Go definition'}))
  vim.keymap.set('n', 'gi', function() vim.lsp.buf.implementation() end, optiones({desc = 'LSP Implementation'}))
  vim.keymap.set('n', 'gr', function() vim.lsp.buf.references() end, optiones({desc = 'LSP References'}))
  vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, optiones({desc = 'LSP Hover'}))
  vim.keymap.set('n', '<C-k>', function() vim.lsp.buf.signature_help() end, optiones({desc = 'LSP Signature help'}))
  vim.keymap.set('n', '<leader>rn', function() vim.lsp.buf.rename() end, optiones({desc = 'LSP Rename'}))
  vim.keymap.set('n', '<leader>vd', function() vim.lsp.buf.open_float() end, optiones({desc = 'LSP Open float'}))
  vim.keymap.set('n', '<leader>vws', function() vim.lsp.buf.workspace_symbol() end, optiones({desc = 'LSP Workspace symbol'}))
  vim.keymap.set('n', '<leader>wa', function() vim.lsp.buf.add_workspace_folder() end, optiones({desc = 'LSP Add workspace symbol'}))
  vim.keymap.set('n', '<leader>wr', function() vim.lsp.buf.remove_workspace_folder() end, optiones({desc = 'LSP Remove workspace symbol'}))
  vim.keymap.set('n', '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, optiones({desc = 'LSP List workspace folders'}))
  vim.keymap.set('n', '<leader>ca', function() vim.lsp.buf.code_action() end, optiones({desc = 'LSP Code action'}))
  vim.keymap.set('n', '<leader>ftt', function() vim.lsp.buf.formatting() end, optiones({desc = 'LSP Format'}))

  vim.keymap.set('n', 'gR', require('telescope.builtin').lsp_references, {desc = 'Telescope Lsp References'})
  vim.keymap.set('n', 'gD', require('telescope.builtin').lsp_definitions, {desc = 'Telescope Lsp Definitions'})
end

function M.diagnostic_keymaps()
  vim.keymap.set('n', '[d', function() vim.lsp.diagnostic.goto_prev() end, optiones({desc = 'LSP Goto prev'}))
  vim.keymap.set('n', ']d', function() vim.lsp.diagnostic.goto_next() end, optiones({desc = 'LSP Goto next'}))
  vim.keymap.set('n', '<leader>ld', function() vim.lsp.diagnostic.set_loclist() end, optiones({desc = 'LSP Loc list'})) -- TODO doesnot work
end

return M
