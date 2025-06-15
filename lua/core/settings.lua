-- ███████╗███████╗████████╗████████╗██╗███╗   ██╗ ██████╗ ███████╗
-- ██╔════╝██╔════╝╚══██╔══╝╚══██╔══╝██║████╗  ██║██╔════╝ ██╔════╝
-- ███████╗█████╗     ██║      ██║   ██║██╔██╗ ██║██║  ███╗███████╗
-- ╚════██║██╔══╝     ██║      ██║   ██║██║╚██╗██║██║   ██║╚════██║
-- ███████║███████╗   ██║      ██║   ██║██║ ╚████║╚██████╔╝███████║
-- ╚══════╝╚══════╝   ╚═╝      ╚═╝   ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝

-----------------------------------------------------------
-- Neovim API aliases
-----------------------------------------------------------
local cmd = vim.cmd -- Execute Vim commands
local exec = vim.api.nvim_exec -- Execute Vimscript
local g = vim.g -- Global variables
local opt = vim.opt -- Set options (global/buffer/windows-scoped)

-- Change leader to a space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-----------------------------------------------------------
-- General
-----------------------------------------------------------
vim.opt.mouse = "a" -- Enable mouse support
vim.opt.swapfile = false -- Don't use swapfile
-- vim.opt.completeopt = 'menuone,noselect'  -- Autocomplete options
vim.opt.completeopt = { "menu", "menuone", "noselect", "preview" } -- Autocomplete options
vim.opt.backup = false -- No backup
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir" -- Long history
vim.opt.undofile = true -- Undo file

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
    vim.opt.clipboard = "unnamedplus"
end)

vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

-- Enable break indent
vim.opt.breakindent = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------
vim.opt.title = true -- Change the terminal's title
vim.opt.number = true -- Show line number
vim.opt.relativenumber = false -- Show numbers relative to current line
vim.opt.showmatch = true -- Highlight matching parenthesis
-- vim.opt.foldmethod = 'indent'             -- Fold on each indent (default 'foldmarker')
vim.opt.colorcolumn = "80,120" -- Line lenght marker at 80 columns
vim.opt.splitright = true -- Vertical split to the right
vim.opt.splitbelow = true -- Orizontal split to the bottom
vim.opt.ignorecase = true -- Ignore case letters when search
vim.opt.smartcase = true -- Ignore lowercase for the whole pattern
vim.opt.linebreak = true -- Wrap on word boundary
-- vim.opt.wrap = false
vim.opt.termguicolors = true -- Enable 24-bit RGB colors
vim.opt.cursorline = true -- Enable line highlight
vim.opt.cursorcolumn = true -- Enable column highlight
vim.opt.signcolumn = "auto:3" -- Set 3 column for gitsigns and lsp
vim.opt.scrolloff = 10 -- Keep lines above and below cursor
vim.opt.hlsearch = true -- Highlight in search
vim.opt.incsearch = true --
vim.opt.showcmd = true
vim.g.have_nerd_font = true
-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.shiftwidth = 4 -- Shift 4 spaces when tab
vim.opt.tabstop = 4 -- 1 tab == 4 spaces
vim.opt.softtabstop = 4 --
vim.opt.smartindent = true -- Autoindent new lines
vim.opt.autoindent = true

-----------------------------------------------------------
-- Memory, CPU
-----------------------------------------------------------
vim.opt.hidden = true -- Enable background buffers
vim.opt.history = 100 -- Remember N lines in history
vim.opt.lazyredraw = false -- true : Faster scrolling (temporary)
vim.opt.synmaxcol = 240 -- Max column for syntax highlight
-- Decrease update time
vim.opt.updatetime = 200 -- ms to wait for trigger 'document_highlight'

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-----------------------------------------------------------
-- netrw
-----------------------------------------------------------
g.netrw_liststyle = 3

-----------------------------------------------------------
-- other
-----------------------------------------------------------
-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

vim.opt.autoread = false -- Don't read a file when it was changed outside of nvim
vim.opt.encoding = "UTF-8" -- Default encoding
vim.opt.confirm = true -- Confirm before closing an unsaved buffer

-----------------------------------------------------------
-- Startup
-----------------------------------------------------------
-- Disable nvim intro
vim.opt.shortmess:append("sI")

-- Disable builtins plugins
local disabled_built_ins = {
    --"netrw",
    --"netrwPlugin",
    --"netrwSettings",
    --"netrwFileHandlers",
    "gzip",
    "zip",
    "zipPlugin",
    "tar",
    "tarPlugin",
    "getscript",
    "getscriptPlugin",
    "vimball",
    "vimballPlugin",
    "2html_plugin",
    "logipat",
    "rrhelper",
    "spellfile_plugin",
    "matchit",
}

for _, plugin in pairs(disabled_built_ins) do
    g["loaded_" .. plugin] = 1
end

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])
