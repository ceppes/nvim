local dap_status_ok, dap = pcall(require, 'dap')
if not dap_status_ok then
  return
end

local dapui_status_ok, dapui = pcall(require, 'dapui')
if not dapui_status_ok then
  return
end

local dap_virtual_text_status_ok, dap_virtual_text = pcall(require, 'nvim-dap-virtual-text')
if not dap_virtual_text_status_ok then
  return
end

local which_key_status_ok, which_key = pcall(require, 'which-key')
if not which_key_status_ok then
  return
end

-- configure
local dap_breakpoint = {
  error = {
    text = "🔴",
    texthl = "LspDiagnosticsSignError",
    linehl = "",
    numhl = "",
  },
  rejected = {
    text = "❌",
    texthl = "LspDiagnosticsSignHint",
    linehl = "",
    numhl = "",
  },
  stopped = {
    text = "▶️",
    texthl = "LspDiagnosticsSignInformation",
    linehl = "DiagnosticUnderlineInfo",
    numhl = "LspDiagnosticsSignInformation",
  },
}

vim.fn.sign_define("DapBreakpoint", dap_breakpoint.error)
vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)
vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.rejected)

-- configure exts
dap_virtual_text.setup{
  commented = true,
}

  -- open, close and toggle the windows
-- dap.setup{}
dapui = require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end


-- configure debuggers
-- require("config.dap.lua").setup()
-- require("config.dap.python").setup()
-- require("config.dap.rust").setup()
-- require("config.dap.go").setup()

-- Keymaps
-- require("config.dap.keymaps").setup()
local function map(mode, lhs, rhs, opts)
  -- noremap : no recursive mapping
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map('n', '<leader>dR', "<cmd>lua require'dap'.run_to_cursor()<cr>", {desc = "Run to Cursor"})
map('n', '<leader>dE', "<cmd>lua require'dapui'.eval(vim.fn.input '[Expression] > ')<cr>", {desc = "Evaluate Input"})
map('n', '<leader>dC', "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>", {desc = "Conditional Breakpoint" })
map('n', '<leader>dU', "<cmd>lua require'dapui'.toggle()<cr>", {desc = "Toggle UI" })
map('n', '<leader>db', "<cmd>lua require'dap'.step_back()<cr>", {desc = " Step Back" })
map('n', '<leader>dc', "<cmd>lua require'dap'.continue()<cr>", {desc = " Continue" })
-- local icon = vim.fn.nr2char(61453)
map('n', '<leader>dd', "<cmd>lua require'dap'.disconnect()<cr>", {desc = "□ Disconnect" })
map('n', '<leader>de', "<cmd>lua require'dapui'.eval()<cr>", {desc = "Evaluate" })
map('v', '<leader>de', "<cmd>lua require'dapui'.eval()<cr>", {desc = "Evaluate" })
map('n', '<leader>dg', "<cmd>lua require'dap'.session()<cr>", {desc = "Get Session" })
map('n', '<leader>dh', "<cmd>lua require'dap.ui.widgets'.hover()<cr>", {desc = "Hover Variables" })
map('n', '<leader>dS', "<cmd>lua require'dap.ui.widgets'.scopes()<cr>", {desc = "Scopes" })
-- local icon = vim.fn.nr2char(63162)
map('n', '<leader>di', "<cmd>lua require'dap'.step_into()<cr>", {desc = " Step Into"})
-- local icon = vim.fn.nr2char(63164)
map('n', '<leader>do', "<cmd>lua require'dap'.step_over()<cr>", {desc = " Step Over" })
-- local icon = vim.fn.nr2char(63715)
map('n', '<leader>dp', "<cmd>lua require'dap'.pause.toggle()<cr>", {desc = " Pause" })
map('n', '<leader>dq', "<cmd>lua require'dap'.close()<cr>", {desc = "Quit" })
map('n', '<leader>dr', "<cmd>lua require'dap'.repl.toggle()<cr>", {desc = "Toggle Repl" })
-- local icon = vim.fn.nr2char(61515)
map('n', '<leader>ds', "<cmd>lua require'dap'.continue()<cr>", {desc = " Start" })
map('n', '<leader>dt', "<cmd>lua require'dap'.toggle_breakpoint()<cr>", {desc = "Toggle Breakpoint" })
map('n', '<leader>dx', "<cmd>lua require'dap'.terminate()<cr>", {desc = "□ Terminate" })
-- local icon = vim.fn.nr2char(63163)
map('n', '<leader>du', "<cmd>lua require'dap'.step_out()<cr>", {desc = " Step Out" })

which_key.register({
  d = {
    name = "Debug",
  }
}, {
  mode = "n",
  prefix = "<leader>",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
})

-- Telescope dap conf
require('telescope').load_extension('dap')
map('n', '<leader>dTc', "<cmd>lua require'telescope'.extensions.dap.configurations{}<cr>", {desc = "Telescope config" })
map('n', '<leader>dTb', "<cmd>lua require'telescope'.extensions.dap.list_breakpoints{}<cr>", {desc = "Telescope list breakpoints" })
map('n', '<leader>dTl', "<cmd>lua require'telescope'.extensions.dap.commands{}<cr>", {desc = "Telescope commands" })

dapui.setup({
  icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  -- Expand lines larger than the window
  -- Requires >= 0.7
  expand_lines = vim.fn.has("nvim-0.7"),
  -- Layouts define sections of the screen to place windows.
  -- The position can be "left", "right", "top" or "bottom".
  -- The size specifies the height/width depending on position. It can be an Int
  -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
  -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
  -- Elements are the elements shown in the layout (in order).
  -- Layouts are opened in order so that earlier layouts take priority in window sizing.
  layouts = {
    {
      elements = {
      -- Elements can be strings or table with id and size keys.
        { id = "scopes", size = 0.25 },
        "breakpoints",
        "stacks",
        "watches",
      },
      size = 40, -- 40 columns
      position = "left",
    },
    {
      elements = {
        "repl",
        "console",
      },
      size = 0.25, -- 25% of total lines
      position = "bottom",
    },
  },
  controls = {
    -- Requires Neovim nightly (or 0.8 when released)
    enabled = true,
    -- Display controls in this element
    element = "repl",
    icons = {
      pause = "",
      play = "",
      step_into = "",
      step_over = "",
      step_out = "",
      step_back = "",
      run_last = "↻",
      terminate = "□",
    },
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = "single", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
  render = {
    max_type_length = nil, -- Can be integer or nil.
    max_value_lines = 100, -- Can be integer or nil.
  }
})

-- config python
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
      return '~/.pyenv/shims/python'
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
}
