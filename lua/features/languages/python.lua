local M = {}

M.linter = 'pylint'
M.lspbin = 'pyright-langserver'
M.debugger = 'debugpy'

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
          }
        }
      }
    })
end


function M.debugger()
  local dap_status_ok, dap = pcall(require, 'dap')
  if not dap_status_ok then
    return
  end

  local python_path = vim.env.HOME .. '/.pyenv/shims/python'

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
        return python_path
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
      pythonPath = function()
        return python_path
      end,
      args = {'test'}
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
