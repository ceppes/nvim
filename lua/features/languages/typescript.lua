local M = {}

M.linter = 'eslint_d'
M.lsp_key = 'ts_ls'
M.lspbin = 'typescript-language-server'
M.debugger = ''
M.treesitter = 'typescript'

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
      filetypes = {"typescript", "typescriptreact", "typescript.tsx"},
      cmd = { M.lspbin, "--stdio"},
      root_dir = lspconfig.util.root_pattern(unpack(root_files)),
      init_options = {
        hostInfo = "neovim",
        preferences = {
          quotePreference = "double",
          includeCompletionsWithSnippetText = true,
          generateReturnInDocTemplate = true,
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        }
      }
    }
  )
end

return M
