local M = {}

M.lsp_key = "jsonls"
M.lspbin = "json-lsp"
M.lspbin = "vscode-json-language-server"
M.treesitter = "json"
M.lint = "jsonlint"
M.filetype = "json"

vim.api.nvim_create_autocmd("FileType", {
	pattern = M.filetype,
	callback = function()
		vim.bo.formatexpr = ""
		vim.bo.formatprg = "jq"
	end,
})

function M.lsp()
	return require("features.lsp.server_config").config(M.lspbin, {
		filetypes = {
			"json",
			"jsonc",
		},
	})
end

return M
