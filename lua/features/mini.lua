local M = {}
M = { -- Collection of various small independent plugins/modules
    "echasnovski/mini.nvim",
    config = function()
        -- Better Around/Inside textobjects
        --
        -- Examples:
        --  - va)  - [V]isually select [A]round [)]paren
        --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
        --  - ci'  - [C]hange [I]nside [']quote
        require("mini.ai").setup({ n_lines = 500 })

        -- Interactive text alignment
        --
        -- Examples:
        --  - ga<motion> - [G]o [A]lign for motion/text object
        --  - gA<motion> - [G]o [A]lign with preview for motion/text object
        require("mini.align").setup()

        -- Add/delete/replace surroundings (brackets, quotes, etc.)
        --
        -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
        -- - sd'   - [S]urround [D]elete [']quotes
        -- - sr)'  - [S]urround [R]eplace [)] [']
        -- require('mini.surround').setup()
        -- NOTE : conflict with move window
    end,
}

-- Test alignment examples (delete after testing):
-- local x = 10
-- local very_long_variable_name = 20
-- local y = 30
-- local another_var = 40
--
-- | Name | Age | City |
-- | John | 25 | NYC |
-- | Jane | 30 | LA |
--
-- SQL INSERT test (select lines below and use ga, then s,<Enter>):
-- SQL INSERT test (select lines below and use ga, then ,,<Enter>):
-- INSERT INTO users (id, name, email, created_at) VALUES (1, 'John', 'john@email.com', '2023-01-01');
-- INSERT INTO users (id, name, email, created_at) VALUES (25, 'Jane Smith', 'jane.smith@example.org', '2023-02-15');
-- INSERT INTO users (id, name, email, created_at) VALUES (100, 'Bob', 'bob@test.com', '2023-03-20');

return M
