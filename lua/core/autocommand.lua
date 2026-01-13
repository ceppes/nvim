-----------------------------------------------------------
-- Autocommands
-----------------------------------------------------------
local cmd = vim.cmd

-- Filetype detection
vim.filetype.add({
    filename = {
        ["firestore.rules"] = "firestore",
    },
    pattern = {
        [".*%.rules"] = {
            priority = 10,
            function(path)
                local content = vim.fn.readfile(path, "", 10)
                for _, line in ipairs(content) do
                    if line:match("service%s+cloud%.firestore") then
                        return "firestore"
                    end
                end
            end,
        },
    },
})

local function augroup(name)
    return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- Remove whitespace on save
cmd([[autocmd BufWritePre * :%s/\s\+$//e]])

-- Don't auto commenting new lines
cmd([[autocmd BufEnter * set fo-=c fo-=r fo-=o]])

-- Remove line lenght marker for selected filetypes
-- cmd [[
--   autocmd FileType text,markdown,html,xhtml,javascript setlocal cc=0
-- ]]

-- 2 spaces by default
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "*",
--   callback = function()
--     vim.bo.shiftwidth = 2
--     vim.bo.tabstop = 2
--     vim.opt_local.foldmethod='indent'
--     vim.opt_local.expandtab = true
--   end
-- })

-- Set to 1000 to show all levels (except Java which handles its own folding)
vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function()
        -- Skip Java files - they handle their own folding in languages/java.lua
        if vim.bo.filetype ~= "java" then
            vim.opt_local.foldlevel = 1000
        end
    end,
})
-- cmd [[  autocmd FileType python setlocal foldlevel=1 ]]
-- cmd [[  autocmd FileType java setlocal foldlevel=2 ]]
-- cmd [[  autocmd FileType typescript setlocal foldlevel=3 ]]

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
    group = augroup("checktime"),
    command = "checktime",
})

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 600,
        })
    end,
})

-- Resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
    group = augroup("resize_splits"),
    callback = function()
        local current_tab = vim.fn.tabpagenr()
        vim.cmd("tabdo wincmd =")
        vim.cmd("tabnext " .. current_tab)
    end,
})

-- Go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
    group = augroup("last_loc"),
    callback = function(event)
        local exclude = { "gitcommit" }
        local buf = event.buf
        if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
            return
        end
        vim.b[buf].lazyvim_last_loc = true
        local mark = vim.api.nvim_buf_get_mark(buf, '"')
        local lcount = vim.api.nvim_buf_line_count(buf)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- Close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("close_with_q"),
    pattern = {
        "PlenaryTestPopup",
        "help",
        "lspinfo",
        "man",
        "notify",
        "qf",
        "query",
        "spectre_panel",
        "startuptime",
        "tsplayground",
        "neotest-output",
        "checkhealth",
        "neotest-summary",
        "neotest-output-panel",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    end,
})

-- Wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("wrap_spell"),
    pattern = { "gitcommit", "markdown" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    group = augroup("auto_create_dir"),
    callback = function(event)
        if event.match:match("^%w%w+://") then
            return
        end
        local file = vim.loop.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
})
