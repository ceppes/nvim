local M = {}

-- local analyzers_path = vim.fn.stdpath("data") .. "/mason/packages/sonarlint-language-server/extension/analyzers/"
local analyzers_path = vim.fn.stdpath("data") .. "/mason/share/sonarlint-analyzers/"

M = {
    "https://gitlab.com/schrieveslaach/sonarlint.nvim",
    config = function()
        require("sonarlint").setup({
            server = {
                cmd = {
                    "sonarlint-language-server",
                    "-stdio",
                    "-analyzers",
                    analyzers_path .. "sonarpython.jar",
                    analyzers_path .. "sonarcfamily.jar",
                    analyzers_path .. "sonarjava.jar",
                    analyzers_path .. "sonarhtml.jar",
                    -- analyzers_path .. "csharpenterprise.jar ",
                    -- analyzers_path .. "sonarcsharp.jar",
                    -- analyzers_path .. "sonargo.jar ",
                    -- analyzers_path .. "sonariac.jar ",
                    -- analyzers_path .. "sonarjavasymbolicexecution.jar ",
                    analyzers_path .. "sonarjs.jar",
                    -- analyzers_path .. "sonarlintomnisharp.jar",
                    -- analyzers_path .. "sonarphp.jar ",
                    analyzers_path .. "sonartext.jar ",
                    analyzers_path .. "sonarxml.jar ",
                },
            },
            filetypes = {
                -- "c",
                "cpp",
                -- "css",
                -- "docker",
                -- "go",
                -- "html",
                "java",  -- SonarLint is VERY popular for Spring Boot projects
                "javascript",
                "javascriptreact",
                -- "php",
                "python",
                "text",
                -- "typescript",
                -- "typescriptreact",
                "xml",
                -- "yaml.docker-compose",
            },
        })
    end,
}

return M
