local M = {}

M.filetype = "log"

vim.api.nvim_create_autocmd("FileType", {
	pattern = M.filetype,
	callback = function()
		vim.opt.linebreak = false
	end,
})

function M.plugin()
	-- better log highlight
	-- 'MTDL9/vim-log-highlighting',
	return {
		"fei6409/log-highlight.nvim",
		event = "BufRead *.log",
		opts = {},
	}
end

return M
