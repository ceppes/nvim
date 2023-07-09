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
opt.hlsearch = false                  -- No highlight in search
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
opt.lazyredraw = true                 -- Faster scrolling
opt.synmaxcol = 240                   -- Max column for syntax highlight
opt.updatetime = 50                   -- ms to wait for trigger 'document_highlight'

-----------------------------------------------------------
-- netrw
-----------------------------------------------------------
g.netrw_liststyle = 3

-----------------------------------------------------------
-- Startup
-----------------------------------------------------------

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

-----------------------------------------------------------
-- Autocommands
-----------------------------------------------------------

-- Highlight on yank
exec([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=800}
  augroup end
]], false)

-- Remove whitespace on save
cmd [[autocmd BufWritePre * :%s/\s\+$//e]]

-- Don't auto commenting new lines
cmd [[autocmd BufEnter * set fo-=c fo-=r fo-=o]]

-- Remove line lenght marker for selected filetypes
cmd [[
  autocmd FileType text,markdown,html,xhtml,javascript setlocal cc=0
]]

-- 2 spaces for selected filetypes
cmd [[
  autocmd FileType xml,html,xhtml,css,scss,javascript,lua,yaml setlocal shiftwidth=2 tabstop=2
]]

-- Fold
opt.foldmethod = 'indent'             -- Fold on each indent
-- Set to 1 to only show mehtods levels
cmd [[  autocmd FileType * setlocal foldlevel=1000 ]]
cmd [[  autocmd FileType python setlocal foldlevel=1 ]]
cmd [[  autocmd FileType java setlocal foldlevel=2 ]]

-- Remap some commands that I often get wrong
vim.api.nvim_create_user_command('Qa', 'qa', { nargs = 0 })
vim.api.nvim_create_user_command('Q', 'q', { nargs = 0 })
vim.api.nvim_create_user_command('Wa', 'wa', { nargs = 0 })
vim.api.nvim_create_user_command('Wq', 'wq', { nargs = 0 })
