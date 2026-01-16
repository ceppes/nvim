--[[
██╗  ██╗███████╗██╗   ██╗██████╗ ██╗███╗   ██╗██████╗ ██╗███╗   ██╗ ██████╗ ███████╗
██║ ██╔╝██╔════╝╚██╗ ██╔╝██╔══██╗██║████╗  ██║██╔══██╗██║████╗  ██║██╔════╝ ██╔════╝
█████╔╝ █████╗   ╚████╔╝ ██████╔╝██║██╔██╗ ██║██║  ██║██║██╔██╗ ██║██║  ███╗███████╗
██╔═██╗ ██╔══╝    ╚██╔╝  ██╔══██╗██║██║╚██╗██║██║  ██║██║██║╚██╗██║██║   ██║╚════██║
██║  ██╗███████╗   ██║   ██████╔╝██║██║ ╚████║██████╔╝██║██║ ╚████║╚██████╔╝███████║
╚═╝  ╚═╝╚══════╝   ╚═╝   ╚═════╝ ╚═╝╚═╝  ╚═══╝╚═════╝ ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝
--]]

-----------------------------------------------------------
-- Define keymaps of Neovim and installed plugins.
-----------------------------------------------------------
local opts = { noremap = true, silent = true }

-----------------------------------------------------------
-- Neovim shortcuts
-----------------------------------------------------------

-- Don't use arrow keys
vim.keymap.set("", "<up>", "<nop>")
vim.keymap.set("", "<down>", "<nop>")
vim.keymap.set("", "<left>", "<nop>")
vim.keymap.set("", "<right>", "<nop>")

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlighting" })

vim.keymap.set("n", "<leader>q", ":qa!<CR>", { desc = "Close all windows and exit" })

vim.keymap.set("n", "<leader>nn", vim.cmd.Ex, { desc = "File : Access netrw" })

vim.keymap.set("n", "<C-s>", ":w<CR>", { desc = "Save" })
vim.keymap.set("i", "<C-s>", "<ESC>:w<CR>a", { desc = "Save" })
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save" })
vim.keymap.set("n", "ss", ":w<CR>", { desc = "Save" })
vim.keymap.set("n", "sa", ":wa<CR>", { desc = "Save all" })

-----------------------------------------------------------
-- Windows
-----------------------------------------------------------
-- Move around splits using Ctrl + {h,j,k,l}
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Move window
vim.keymap.set("n", "sh", "<C-w>h", { desc = "Move focus to the left window" })
vim.keymap.set("n", "sj", "<C-w>j", { desc = "Move focus to the right window" })
vim.keymap.set("n", "sk", "<C-w>k", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "sl", "<C-w>l", { desc = "Move focus to the upper window" })

-- Split window
vim.keymap.set("n", "sS", ":split<CR>", opts)
vim.keymap.set("n", "sV", ":vsplit<CR>", opts)

-- Resize window
vim.keymap.set("n", "<C-w><left>", "<C-w><")
vim.keymap.set("n", "<C-w><right>", "<C-w>>")
vim.keymap.set("n", "<C-w><up>", "<C-w>+")
vim.keymap.set("n", "<C-w><down>", "<C-w>-")

-- Resize window
vim.keymap.set("n", "<S-Up>", "<CMD>resize +2<CR>", { desc = "Increase window height", silent = true })
vim.keymap.set("n", "<S-Down>", "<CMD>resize -2<CR>", { desc = "Decrease window height", silent = true })
vim.keymap.set("n", "<S-Left>", "<CMD>vertical resize -2<CR>", { desc = "Decrease window width", silent = true })
vim.keymap.set("n", "<S-Right>", "<CMD>vertical resize +2<CR>", { desc = "Increase window width", silent = true })

-----------------------------------------------------------
-- Applications and Plugins shortcuts
-----------------------------------------------------------

-- Paste over currently selected text without yanking it
vim.keymap.set("v", "<leader>p", '"_dP', { desc = "Over paste" })

vim.keymap.set("n", "<leader>y", '"+y', { desc = "Copy to system" })
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Copy to system" })
vim.keymap.set("n", "<leader>Y", 'gg"+yG', { desc = "Copy all file to system" })

-- map('n', '<leader>d', '"_d')
-- map('v', '<leader>d', '"_d')

vim.keymap.set("n", "<leader>ft", function()
    vim.lsp.buf.format()
end, { desc = "Format buffer" })

vim.keymap.set("n", "<leader>jq", "<cmd>%!jq .<cr>", { desc = "Format json" })
vim.keymap.set("n", "<leader>jqs", "<cmd>%!jq -S .<cr>", { desc = "Format json and sort by name" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move visual line up" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move visual line down" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Go up with keeping cursor in the middle" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Go down with keeping cursor in the middle" })

vim.keymap.set("n", "n", "nzzzv", { desc = "Next search inc with cursor in the middle" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Next search inc with cursor in the middle" })

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Live replace word" })

-- Map <leader>x in normal mode to run the Lua function
vim.keymap.set("n", "<leader>xx", function()
    -- Ask for confirmation using vim.fn.confirm
    local answer = vim.fn.confirm("Make file executable?", "&Yes\n&No", 2)
    if answer == 1 then
        local file = vim.fn.expand("%:p")
        os.execute("chmod +x " .. vim.fn.shellescape(file))
        print("File made executable!")
    else
        print("Cancelled.")
    end
end, { noremap = true, silent = true, desc = "chmod +x current_file with confirmation" })

vim.keymap.set("n", "+", "<C-a>", { desc = "Increment" })
vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement" })

vim.keymap.set("n", "<C-a>", "gg<S-v>G", { desc = "Select all" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
-- NOTE: Conflict with Lazygit
-- vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Custom fold

-- local hush = { silent = true }
-- vim.vim.keymap.set("v", "<space>", ":fold<CR>", hush)
-- vim.vim.keymap.set("n", "<space>", "zA", hush)

-----------------------------------------------------------
-- Markdown checkboxes
-----------------------------------------------------------
local function set_checkbox(state)
    local line = vim.api.nvim_get_current_line()
    local new_line = line:gsub("%- %[.%]", "- [" .. state .. "]")
    if new_line ~= line then
        vim.api.nvim_set_current_line(new_line)
    end
end

vim.keymap.set("n", "<leader>mu", function() set_checkbox(" ") end, { desc = "Checkbox: unchecked" })
vim.keymap.set("n", "<leader>mc", function() set_checkbox("x") end, { desc = "Checkbox: checked" })
vim.keymap.set("n", "<leader>mt", function() set_checkbox("-") end, { desc = "Checkbox: todo" })
