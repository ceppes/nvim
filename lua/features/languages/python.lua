local M = {}

M.linter = 'pylint'
M.lspbin = 'pyright-langserver'
M.debugger = 'debugpy'

local util = require('lspconfig/util')
local path = util.path

local function get_python_path(workspace)
  -- Use activated virtualenv.
  if vim.env.VIRTUAL_ENV then
    return path.join(vim.env.VIRTUAL_ENV, 'bin', 'python')
  end

 -- Find and use virtualenv via poetry in workspace directory.
  local match = vim.fn.glob(path.join(workspace, 'poetry.lock'))
  if match ~= '' then
    local venv = vim.fn.trim(vim.fn.system('poetry env info -p'))
    return path.join(venv, 'bin', 'python')
  end

  -- Find and use virtualenv in workspace directory.
  for _, pattern in ipairs({'*', '.*'}) do
    local match = vim.fn.glob(path.join(workspace, pattern, 'pyvenv.cfg'))
    if match ~= '' then
      return path.join(path.dirname(match), 'bin', 'python')
    end
  end

  -- Fallback to system Python.
  return exepath('python3') or exepath('python') or 'python'
end

function M.lsp()
  local lsp_status_ok, lspconfig = pcall(require, 'lspconfig')
  if not lsp_status_ok then
    return
  end

  local python_root_files = {
    'WORKSPACE',
    'pyproject.toml',
    'setup.py',
    'setup.cfg',
    'requirements.txt',
    'Pipfile',
    'pyrightconfig.json',
    '.git'
  }


  return require("features.lsp.server_config").config(
    M.lspbin,
    {
      root_dir = lspconfig.util.root_pattern(unpack(python_root_files)),
      flags = {
        debounce_text_changes = 150,
      },
      settings = {
        python = {
          analysis = {
            autoSearchPaths = true,
            diagnosticMode = "workspace",
            useLibraryCodeForTypes = true,
            typeCheckingMode = "off"
          }
        }
      },
      before_init = function(_, config)
        config.settings.python.pythonPath = get_python_path(config.root_dir)
      end
    }
  )
end

function M.debugger()
  local dap_status_ok, dap = pcall(require, 'dap')
  if not dap_status_ok then
    return
  end

  dap.adapters.python = {
    type = 'executable';
    command = function(config)
      return get_python_path(config.root_dir)
    end;
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
      pythonPath = function(config)
        return get_python_path(config.root_dir)
      end;
    },
      {
    },
    {
      name = "Python: Run pytest";
      type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
      request = 'launch';
      module = "pytest";
      args = function()
        local filter = vim.fn.input('Enter unittest args: ')
        return {'-v', filter}
      end,
      pythonPath = function(config)
        return get_python_path(config.root_dir)
      end,
      -- args = {'test'}
    -- program = "-m pytest ${file}";
    },
    {
      name = "Python: Attach",
      type = "python",
      request = "attach",
      connect = {
        port = 5678,
        -- host = "localhost",
        host = "127.0.0.1",
      },
    }
  }
end

return M
