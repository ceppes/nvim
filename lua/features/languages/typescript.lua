local M = {}

M.linter = 'eslint_d'
M.lsp_key = 'ts_ls'
M.lspbin = 'typescript-language-server'
M.debugger = ''
M.treesitter = {'typescript', 'tsx'}
M.filetypes = {"typescript", "typescriptreact", "typescript.tsx"}

vim.api.nvim_create_autocmd("FileType", {
  pattern = M.filetypes,
  callback = function()
    vim.notify("fold method yyy")
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 2
    vim.opt_local.foldmethod='indent'
    vim.opt_local.expandtab = true
    -- vim.opt_local.foldmethod='expr'
    -- vim.opt_local.foldexpr=vim.treesitter.foldexpr()
  end
})

function M.lsp()
  local lsp_status_ok, lspconfig = pcall(require, 'lspconfig')
  if not lsp_status_ok then
    return
  end

  local root_files = {
    'package.json',
    'tsconfig.json',
    '.git'
  }

  return require("features.lsp.server_config").config(
    M.lspbin,
    {
      filetypes = M.filetypes,
      cmd = { M.lspbin, "--stdio"},
      root_dir = lspconfig.util.root_pattern(unpack(root_files)),
      settings = {
	typescript = {
	   inlayHints = {
	      includeInlayParameterNameHints = "literal",
	      includeInlayParameterNameHintsWhenArgumentMatchesName = false,
	      includeInlayFunctionParameterTypeHints = true,
	      includeInlayVariableTypeHints = false,
	      includeInlayPropertyDeclarationTypeHints = true,
	      includeInlayFunctionLikeReturnTypeHints = true,
	      includeInlayEnumMemberValueHints = true,
	   },
	},
	javascript = {
	   inlayHints = {
	      includeInlayParameterNameHints = "all",
	      includeInlayParameterNameHintsWhenArgumentMatchesName = false,
	      includeInlayFunctionParameterTypeHints = true,
	      includeInlayVariableTypeHints = true,
	      includeInlayPropertyDeclarationTypeHints = true,
	      includeInlayFunctionLikeReturnTypeHints = true,
	      includeInlayEnumMemberValueHints = true,
	   },
	},
	-- init_options = {
	--   hostInfo = "neovim",
	--   preferences = {
	--     quotePreference = "double",
	--     includeCompletionsWithSnippetText = true,
	--     generateReturnInDocTemplate = true,
	--     includeInlayParameterNameHints = "all",
	--     includeInlayParameterNameHintsWhenArgumentMatchesName = true,
	--     includeInlayFunctionParameterTypeHints = true,
	--     includeInlayVariableTypeHints = true,
	--     includeInlayPropertyDeclarationTypeHints = true,
	--     includeInlayFunctionLikeReturnTypeHints = true,
	--     includeInlayEnumMemberValueHints = true,
 --        }
      }
    }
  )
end

return M
