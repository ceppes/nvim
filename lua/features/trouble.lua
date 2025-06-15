local M = {}

M = {
	"folke/trouble.nvim",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		require("features.trouble").setup()
		require("features.trouble").keymaps()
	end,
}

function M.keymaps()
	vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
	vim.keymap.set(
		"n",
		"<leader>xX",
		"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
		{ desc = "Buffer Diagnostics (Trouble)" }
	)
	vim.keymap.set("n", "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols (Trouble)" })
	vim.keymap.set(
		"n",
		"<leader>xl",
		"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
		{ desc = "LSP Definitions / references / ... (Trouble)" }
	)
	vim.keymap.set("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List (Trouble)" })
	vim.keymap.set("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List (Trouble)" })
	vim.keymap.set("n", "<leader>xr", "<cmd>Trouble lsp_references<cr>")
end

function M.setup()
	require("trouble").setup()
	require("which-key").add({
		{ "<leader>x", group = "Trouble" },
	})
end

return M
