local M = {}

M = {
    "https://gitlab.com/schrieveslaach/sonarlint.nvim",
    config = function()
        require("sonarlint").setup({
            server = {
                cmd = {
                    "sonarlint-language-server",
                    -- Ensure that sonarlint-language-server uses stdio channel
                    "-stdio",
                    "-analyzers",
                    -- paths to the analyzers you need
                    vim.fn.expand("~/.local/share/nvim/mason/sonarlint-analyzers/sonarpython.jar"),
                    vim.fn.expand("~/.local/share/nvim/mason/sonarlint-analyzers/sonarcfamily.jar"),
                    -- vim.fn.expand("~/.local/share/nvim/mason/sonarlint-analyzers/sonarjava.jar"),
                    vim.fn.expand("~/.local/share/nvim/mason/sonarlint-analyzers/sonarhtml.jar"),
                    -- vim.fn.expand("~/.local/share/nvim/mason/sonarlint-analyzers/csharpenterprise.jar "),
                    -- vim.fn.expand("~/.local/share/nvim/mason/sonarlint-analyzers/sonarcsharp.jar"),
                    -- vim.fn.expand("~/.local/share/nvim/mason/sonarlint-analyzers/sonargo.jar "),
                    -- vim.fn.expand("~/.local/share/nvim/mason/sonarlint-analyzers/sonariac.jar "),
                    -- vim.fn.expand("~/.local/share/nvim/mason/sonarlint-analyzers/sonarjavasymbolicexecution.jar "),
                    vim.fn.expand("~/.local/share/nvim/mason/sonarlint-analyzers/sonarjs.jar"),
                    -- vim.fn.expand("~/.local/share/nvim/mason/sonarlint-analyzers/sonarlintomnisharp.jar"),
                    -- vim.fn.expand("~/.local/share/nvim/mason/sonarlint-analyzers/sonarphp.jar "),
                    vim.fn.expand("~/.local/share/nvim/mason/sonarlint-analyzers/sonartext.jar "),
                    vim.fn.expand("~/.local/share/nvim/mason/sonarlint-analyzers/sonarxml.jar "),
                },
            },
            filetypes = {
                -- Tested and working
                "python",
                "cpp",
                -- 'java',
                "html",
                "js",
                "text",
                "xml",
            },
        })
    end,
}

return M
