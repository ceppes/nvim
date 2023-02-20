
local lint = require 'lint'
lint.linters_by_ft = {
  python = {'pylint'},
  terraformls = {'terraformls'}
}


local dap_status_ok, dap = pcall(require, 'dap')
if not dap_status_ok then
  return
end

local python_path = '/Users/diego/.pyenv/shims/python'

dap.adapters.python = {
  type = 'executable';
  command = python_path;
  args = { '-m', 'debugpy.adapter' };
}

dap.configurations.python = {
  {
    -- The first three options are required by nvim-dap
    name = "Python : Current file";
    type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
    request = 'launch';

    -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

    program = "${file}"; -- This configuration will launch the current file if used.
    pythonPath = function()
      return '/Users/diego/.pyenv/shims/python'
      -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
      -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
      -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
      -- local cwd = vim.fn.getcwd()
      -- if vim.fn.executable(cwd .. python_path) == 1 then
      --   return cwd .. python_path
      -- elseif vim.fn.executable(cwd .. python_path) == 1 then
      --   return cwd .. python_path
      -- else
      --   return python_path
      -- end
    end;
  },
    {
  },
  {
    name = "Run pytest";
    type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
    request = 'launch';
    module = "pytest";
    args = function()
      local filter = vim.fn.input('Enter unittest args: ')
      return {'-v', filter}
    end
  },
  -- {
  --   name = "Python : Attach using Process Id",
  --   type = 'python',
  --   request = 'attach',
  --   proc
  -- }
}
-- require("dap-python").setup("python", {})
