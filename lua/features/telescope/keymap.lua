require("which-key").add({
    { "<leader>f", group = "Find" },
    { "<leader>fh", group = "Hidden" },
})

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]ind [F]iles" })
vim.keymap.set("n", "<leader>fhf", function()
    builtin.find_files({ hidden = true })
end, { desc = "[F]ind [H]iden [F]iles" })
vim.keymap.set("n", "<leader>fl", builtin.live_grep, { desc = "[F]ind [L]ive grep" })
vim.keymap.set("n", "<leader>fhl", function()
    builtin.live_grep({
        additional_args = function(_)
            return { "--hidden" }
        end,
    })
end, { desc = "[F]ind [H]idden [L]ive grep" })
vim.keymap.set("n", "<leader>fg", builtin.git_files, { desc = "[F]ind [G]it files" })
vim.keymap.set("n", "<leader>fs", builtin.grep_string, { desc = "[F]ind grep [S]tring - current word" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "[F]ind [B]uffers" })
vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "[F]ind [K]eymaps" })
vim.keymap.set("n", "<leader>ft", builtin.help_tags, { desc = "[F]ind Help [T]ag" })
vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "[F]ind [R]esume" })
vim.keymap.set("n", "<leader>fp", builtin.pickers, { desc = "[F]ind [P]ickers" })
vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "[F]ind [D]iagnostic" })
vim.keymap.set("n", "<leader>fB", builtin.builtin, { desc = "[F]ind [B]uiltin [B]uiltin Telescope" })
vim.keymap.set("n", "<leader>fH", builtin.command_history, { desc = "[F]ind Command [H]istory" })
vim.keymap.set("n", "<leader>f.", builtin.oldfiles, { desc = '[F]ind Recent files ("[.]" for repeat)' })

vim.keymap.set("n", "<leader>f/", function()
    builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        winblend = 10,
        previewer = false,
    }))
end, { desc = "Find [/] Fuzzily search in current buffer" })

vim.keymap.set("n", "<leader>f/", function()
    builtin.live_grep({
        grep_open_files = true,
        prompt_title = "Live Grep in Open Files",
    })
end, { desc = "[F]ind [/] in Open Files" })

vim.keymap.set("n", "<leader>fn", function()
    builtin.find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = "[F]ind [N]eovim files" })

vim.keymap.set("v", "<leader>fcl", function()
    local function get_visual_selection()
        vim.cmd('noau normal! "vy"')
        return vim.fn.getreg("v")
    end
    require("telescope.builtin").live_grep({
        default_text = get_visual_selection(),
        prompt_title = "Live Grep on visually selected text",
    })
end, { noremap = true, silent = true, desc = "[F]ind [C]urrent visually selected text [L]ive Grep" })
