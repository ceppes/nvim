local M = {}

M = {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "antoinemadec/FixCursorHold.nvim",
        -- Adapters
        "nvim-neotest/neotest-python",
        "rcasia/neotest-java", -- adapter Java (JUnit via Maven/Gradle + jdtls)
        -- coverage
        "andythigpen/nvim-coverage",
        -- LSP Java
        "mfussenegger/nvim-jdtls",
    },
    config = function()
        local neotest = require("neotest")
        neotest.setup({
            adapters = {
                require("neotest-python")({
                    runner = "pytest", -- or "unittest"
                    dap = {
                        justMyCode = false,
                    },
                }),
                require("neotest-java")({}),
            },
            diagnostic = {
                enabled = true,
            },
            quickfix = {
                enabled = false,
            },
            summary = {
                open = "botright vsplit | vertical resize 60",
            },
            output = {
                open_on_run = false,
            },
        })

        local map = vim.keymap.set
        map("n", "<leader>te", function()
            neotest.run.run()
        end, { desc = "Test nearest" })
        map("n", "<leader>tf", function()
            neotest.run.run(vim.fn.expand("%"))
        end, { desc = "Test file" })
        map("n", "<leader>ts", function()
            neotest.summary.toggle()
        end, { desc = "Toggle test summary" })
        map("n", "<leader>to", function()
            neotest.output.open({ enter = true, auto_close = true })
        end, { desc = "Open test output" })
        map("n", "<leader>ta", function()
            neotest.run.attach()
        end, { desc = "Attach to running test" })
        map("n", "<leader>td", function()
            neotest.run.run({ strategy = "dap" })
        end, { desc = "Debug nearest test" })

        local coverage = require("coverage")
        coverage.setup({
            -- read formats lcov et cobertura
            auto_reload = true,
            summary = {
                -- customize the summary pop-up
                min_coverage = 80.0, -- minimum coverage threshold (used for highlighting)
            },
            -- highlights = {
            --     covered = {
            --         fg = nil,
            --         bg = nil,
            --         style = "underline",
            --     },
            --     uncovered = {
            --         fg = nil,
            --         bg = nil,
            --         style = "underline",
            --     },
            -- },
            -- signs = {
            --     covered = {
            --         hl = "CoverageCovered",
            --         text = "▎",
            --     },
            --     uncovered = {
            --         hl = "CoverageUncovered",
            --         text = "▎",
            --     },
            -- },
        })
        map("n", "<leader>cv", function()
            coverage.load()
        end, { desc = "Coverage: load" })
        map("n", "<leader>cc", function()
            coverage.clear()
        end, { desc = "Coverage: clear" })
        map("n", "<leader>ct", function()
            coverage.toggle()
        end, { desc = "Coverage: toggle" })
    end,
}

return M
