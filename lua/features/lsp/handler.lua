local M = {}

M = {
	["textDocument/hover"] = vim.lsp.with(vim.lsp.buf.hover, {
		-- border = "rounded",
		anchor = "SW",
		relative = "cursor",
		row = -1,
	}),
	["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
		underline = true,
		update_in_insert = false,
		virtual_text = {
			spacing = 4,
			prefix = "\u{ea71}",
		},
		severity_sort = true,
	}),
}

return M
