local M = {}

M = {
	{
		-- Tag viewer
		"liuchengxu/vista.vim",
	},
	{
		"simrat39/symbols-outline.nvim",
		-- cmd = "SymbolsOutline",
		config = function()
			require("features.structure").setup()
			require("features.structure").keymaps()
		end,
	},
}

function M.setup()
	local symbols_outline = require("symbols-outline")
	symbols_outline.setup()
end

function M.keymaps()
	local symbols_outline = require("symbols-outline")
	vim.keymap.set("n", "<leader>h", symbols_outline.toggle_outline, { desc = "Open Structure" })
	vim.keymap.set("n", "<leader>i", ":Vista nvim_lsp<CR>", { desc = "Open Vista LSP" })
end

return M

-- W Fold all
-- l Unfold
-- List of method

-- │   Key    │                      Action                      │
-- │Escape    │Close outline                                     │
-- │Enter     │Go to symbol location in code                     │
-- │o         │Go to symbol location in code without losing focus│
-- │Ctrl+Space│Hover current symbol                              │
-- │K         │Toggles the current symbol preview                │
-- │r         │Rename symbol                                     │
-- │a         │Code actions                                      │
-- │h         │fold symbol                                       │
-- │l         │Unfold symbol                                     │
-- │W         │Fold all symbols                                  │
-- │E         │Unfold all symbols                                │
-- │R         │Reset all folding                                 │
-- │?         │Show help message                                 │
