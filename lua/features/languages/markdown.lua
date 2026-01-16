local M = {}

-- M.linter = "markdownlint"
M.filetypes = { "markdown" }
M.treesitter = { "markdown", "markdown_inline" }

-- Todo report utility (reads current buffer)
local function todo_report()
    -- ## Legend
    -- - `[ ]` Todo
    -- - `[-]` In Progress
    -- - `[x]` Done
    --
    -- Prefixes: `F` Feature | `B` Bug | `T` Technical Debt | `E` Epic
    -- F-001 - unique number
    -- Tags: `TBD` needs refinement/decision

    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

    local status = { todo = 0, progress = 0, done = 0 }
    local prefix = { F = 0, B = 0, T = 0, E = 0 }
    local tbd_count = 0
    local max_number = 0
    local seen_numbers = {} -- Track numbers only (unique across all prefixes)
    local duplicates = {}

    for _, line in ipairs(lines) do
        -- Todo items (- [ ], - [-], - [x])
        local is_todo_line = line:match("^%s*%- %[.%]")
        -- Headers with ID (#### E-101 Title)
        local is_header_with_id = line:match("^#+ [FBTE]%-(%d+)")

        if is_todo_line then
            if line:match("%- %[ %]") then
                status.todo = status.todo + 1
            elseif line:match("%- %[%-%]") then
                status.progress = status.progress + 1
            elseif line:match("%- %[x%]") then
                status.done = status.done + 1
            end

            -- Extract ID and check for duplicate numbers (unique across all prefixes)
            local p, num = line:match("([FBTE])%-(%d+)")
            if p and prefix[p] then
                local id = p .. "-" .. num
                if seen_numbers[num] then
                    -- Number already used, flag both as duplicates
                    table.insert(duplicates, id .. " & " .. seen_numbers[num])
                else
                    seen_numbers[num] = id
                    prefix[p] = prefix[p] + 1
                end
                local n = tonumber(num)
                if n and n > max_number then
                    max_number = n
                end
            end

            if line:match("TBD") then
                tbd_count = tbd_count + 1
            end
        elseif is_header_with_id then
            -- Headers like #### E-101 Title
            local p, num = line:match("([FBTE])%-(%d+)")
            if p and prefix[p] then
                local id = p .. "-" .. num
                if seen_numbers[num] then
                    table.insert(duplicates, id .. " & " .. seen_numbers[num])
                else
                    seen_numbers[num] = id
                    prefix[p] = prefix[p] + 1
                end
                local n = tonumber(num)
                if n and n > max_number then
                    max_number = n
                end
            end
        end
    end

    local total = status.todo + status.progress + status.done
    local dup_str = #duplicates > 0 and table.concat(duplicates, ", ") or "none"

    local report = string.format(
        [[
Todo Report
───────────────────────────
Status: [ ] %d  [-] %d  [x] %d  (Total: %d)
Type:   F: %d   B: %d   T: %d   E: %d
TBD:    %d
Next:   %03d
Dupes:  %s
───────────────────────────]],
        status.todo,
        status.progress,
        status.done,
        total,
        prefix.F,
        prefix.B,
        prefix.T,
        prefix.E,
        tbd_count,
        max_number + 1,
        dup_str
    )
    print(report)
end

-- Markdown specific settings
vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        --- Disable LSP text diagnostics for markdown files
        vim.diagnostic.config({ virtual_text = false })
        vim.keymap.set("n", "<leader>mtr", todo_report, { buffer = true, desc = "Todo Report" })
    end,
})

function M.plugin()
    return {
        "MeanderingProgrammer/render-markdown.nvim",
        name = "render-markdown",
        ft = "markdown",
        dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {
            checkbox = {
                checked = {
                    scope_highlight = "@markup.strikethrough",
                },
                custom = {
                    todo = {
                        rendered = "◯ ",
                    },
                },
            },
        },
    }
end

return M
