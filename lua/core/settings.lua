-- ███████╗███████╗████████╗████████╗██╗███╗   ██╗ ██████╗ ███████╗
-- ██╔════╝██╔════╝╚══██╔══╝╚══██╔══╝██║████╗  ██║██╔════╝ ██╔════╝
-- ███████╗█████╗     ██║      ██║   ██║██╔██╗ ██║██║  ███╗███████╗
-- ╚════██║██╔══╝     ██║      ██║   ██║██║╚██╗██║██║   ██║╚════██║
-- ███████║███████╗   ██║      ██║   ██║██║ ╚████║╚██████╔╝███████║
-- ╚══════╝╚══════╝   ╚═╝      ╚═╝   ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝

-----------------------------------------------------------
-- Neovim API aliases
-----------------------------------------------------------
local cmd = vim.cmd		                -- Execute Vim commands
local exec = vim.api.nvim_exec	      -- Execute Vimscript
local g = vim.g			                  -- Global variables
local opt = vim.opt		                -- Set options (global/buffer/windows-scoped)

-----------------------------------------------------------
-- General
-----------------------------------------------------------
opt.mouse = 'a'                       -- Enable mouse support
opt.clipboard = 'unnamedplus'         -- Copy/paste to system clipboard
opt.swapfile = false                  -- Don't use swapfile
opt.completeopt = 'menuone,noselect'  -- Autocomplete options
opt.backup = false                    -- No backup
opt.undodir = os.getenv("HOME") .. "/.vim/undodir" -- Long history
opt.undofile = true                   -- Undo file

-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------
opt.title = true		                  -- Change the terminal's title
opt.number = true                     -- Show line number
opt.relativenumber = false	          -- Show numbers relative to current line
opt.showmatch = true                  -- Highlight matching parenthesis
opt.foldmethod = 'marker'             -- Enable folding (default 'foldmarker')
opt.colorcolumn = '80,120'                -- Line lenght marker at 80 columns
opt.splitright = true                 -- Vertical split to the right
opt.splitbelow = true                 -- Orizontal split to the bottom
opt.ignorecase = true                 -- Ignore case letters when search
opt.smartcase = true                  -- Ignore lowercase for the whole pattern
opt.linebreak = true                  -- Wrap on word boundary
-- opt.wrap = false
opt.termguicolors = true              -- Enable 24-bit RGB colors
opt.cursorline = true                 -- Enable line highlight
opt.cursorcolumn = true               -- Enable column highlight
opt.signcolumn='auto:3'               -- Set 3 column for gitsigns and lsp
opt.scrolloff = 8                     -- Keep lines above and below cursor
opt.hlsearch = true                   -- Highlight in search
opt.incsearch = true                  --
-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
opt.expandtab = true                  -- Use spaces instead of tabs
opt.shiftwidth = 4                    -- Shift 4 spaces when tab
opt.tabstop = 4                       -- 1 tab == 4 spaces
opt.softtabstop = 4                   --
opt.smartindent = true                -- Autoindent new lines

-----------------------------------------------------------
-- Memory, CPU
-----------------------------------------------------------
opt.hidden = true                     -- Enable background buffers
opt.history = 100                     -- Remember N lines in history
opt.lazyredraw = false                -- true : Faster scrolling (temporary)
opt.synmaxcol = 240                   -- Max column for syntax highlight
opt.updatetime = 50                   -- ms to wait for trigger 'document_highlight'

-----------------------------------------------------------
-- netrw
-----------------------------------------------------------
g.netrw_liststyle = 3

-----------------------------------------------------------
-- Startup
-----------------------------------------------------------

-- Fold
opt.foldmethod = 'indent'             -- Fold on each indent


-- Disable nvim intro
opt.shortmess:append "sI"

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
  "matchit"
}


for _, plugin in pairs(disabled_built_ins) do
  g["loaded_" .. plugin] = 1
end
