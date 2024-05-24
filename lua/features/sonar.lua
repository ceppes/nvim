
local M = {}

M = {
  'https://gitlab.com/schrieveslaach/sonarlint.nvim',
  config = function()
    require('sonarlint').setup({
       server = {
          cmd = {
             'sonarlint-language-server',
             -- Ensure that sonarlint-language-server uses stdio channel
             '-stdio',
             '-analyzers',
             -- paths to the analyzers you need, using those for python and java in this example
             vim.fn.expand("~/.local/share/nvim/mason/share/sonarlint-analyzers/sonarpython.jar"),
             vim.fn.expand("~/.local/share/nvim/mason/share/sonarlint-analyzers/sonarcfamily.jar"),
             vim.fn.expand("~/.local/share/nvim/mason/share/sonarlint-analyzers/sonarjava.jar"),
             -- vim.fn.expand("~/.local/share/nvim/mason/share/sonarlint-analyzers/sonarhtml.jar"),
             -- vim.fn.expand("~/.local/share/nvim/mason/share/sonarlint-analyzers/sonarxml.jar"),
             -- vim.fn.expand("~/.local/share/nvim/mason/share/sonarlint-analyzers/sonarjs.jar"),
             -- vim.fn.expand("~/.local/share/nvim/mason/share/sonarlint-analyzers/sonartext.jar"),
          }
       },
       filetypes = {
          -- Tested and working
          'python',
          'cpp',
          'java',
          -- 'html',
          -- 'xml',
          -- 'js'
          -- 'text',
       }
    })

  end

}

return M
