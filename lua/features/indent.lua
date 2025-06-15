local M = {}

M = {
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        config = function()
            require("features.indent").setup()
            require("features.indent").commands()
        end,
    },
    {
        "tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
    },
}

function copy_mode_turn_off()
    vim.opt.listchars:append("space:⋅")
    vim.opt.listchars:append("eol:↴")
    vim.opt.number = true
    require("gitsigns").setup({ current_line_blame = true })
    require("ibl").setup({
        scope = {
            enabled = false,
        },
    })
end

function copy_mode_turn_on()
    vim.opt.listchars:append("space: ")
    vim.opt.listchars:append("eol: ")
    vim.opt.number = false
    -- TODO disable diagnostic sign
    require("gitsigns").setup({ current_line_blame = false })
    require("ibl").setup({
        indent = {
            char = " ",
        },
    })
end

function M.setup()
    local indent_blankline = require("ibl")
    M.copyMode = false
    vim.opt.list = true
    copy_mode_turn_off()
end

function M.commands()
    vim.api.nvim_create_user_command("CopyModeToggle", function()
        if M.copyMode then
            copy_mode_turn_off()
            M.copyMode = false
        else
            copy_mode_turn_on()
            M.copyMode = true
        end
    end, { nargs = 0, desc = "Turn on indent signs" })

    vim.api.nvim_create_user_command("CopyModeOff", function()
        copy_mode_turn_off()
        M.copyMode = false
    end, { nargs = 0, desc = "Turn on indent signs" })

    vim.api.nvim_create_user_command("CopyModeOn", function()
        copy_mode_turn_on()
        M.copyMode = true
    end, { nargs = 0, desc = "Turn off indent signs" })
end

return M
