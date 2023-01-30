local packer = require 'packer'
packer.use {
  'mfussenegger/nvim-dap',
  -- opt = true,
  -- event = "BufReadPre",
  -- module = {
  --   "dap"
  -- },
  wants = {
    "nvim-dap-virtual-text",
    -- "DAPInstall.nvim",
    "nvim-dap-ui",
    "nvim-dap-python",
    "which-key.nvim"
  },
  requires = {
    -- "Pocco81/DAPInstall.nvim",
    "theHamsta/nvim-dap-virtual-text",
    "rcarriga/nvim-dap-ui",
    "mfussenegger/nvim-dap-python",
    "nvim-telescope/telescope-dap.nvim",
    -- { "leoluz/nvim-dap-go", module = "dap-go" },
    -- { "jbyuki/one-small-step-for-vimkind", module = "osv" },
    "jbyuki/one-small-step-for-vimkind",
  },
}

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
  vim.keymap.set(mode, lhs, rhs, options)
end


map('n', '<leader>dR', function() dap.run_to_cursor() end, {desc = "Run to Cursor"})
map('n', '<leader>dE', function() dapui.eval(vim.fn.input '[Expression] > ') end, {desc = "Evaluate Input"})
map('n', '<leader>dC', function() dap.set_breakpoint(vim.fn.input '[Condition] > ') end, {desc = "Conditional Breakpoint" })
map('n', '<leader>dU', function() dapui.toggle() end, {desc = "Toggle UI" })
map('n', '<leader>db', function() dap.step_back() end, {desc = " Step Back" })
map('n', '<leader>dc', function() dap.continue() end, {desc = " Continue" })
-- local icon = vim.fn.nr2char(61453)
map('n', '<leader>dd', function() dap.disconnect() end, {desc = "□ Disconnect" })

map('n', '<leader>de', function() dapui.eval() end, {desc = "Evaluate" })
map('v', '<leader>de', function() dapui.eval() end, {desc = "Evaluate" })
map('n', '<leader>dg', function() dap.session() end, {desc = "Get Session" })
map('n', '<leader>dh', function() dap.ui.widgets.hover() end, {desc = "Hover Variables" })
map('n', '<leader>dS', function() dap.ui.widgets.scopes() end, {desc = "Scopes" })
-- local icon = vim.fn.nr2char(63162)
map('n', '<leader>di', function() dap.step_into() end, {desc = " Step Into"})
-- local icon = vim.fn.nr2char(63164)
map('n', '<leader>do', function() dap.step_over() end, {desc = " Step Over" })
-- local icon = vim.fn.nr2char(63715)
map('n', '<leader>dp', function() dap.pause.toggle() end, {desc = " Pause" })
map('n', '<leader>dq', function() dap.close() end, {desc = "Quit" })
map('n', '<leader>dr', function() dap.repl.toggle() end, {desc = "Toggle Repl" })
-- local icon = vim.fn.nr2char(61515)
map('n', '<leader>ds', function() dap.continue() end, {desc = " Start" })
map('n', '<leader>dt', function() dap.toggle_breakpoint() end, {desc = "Toggle Breakpoint" })
map('n', '<leader>dx', function() dap.terminate() end, {desc = "□ Terminate" })
-- local icon = vim.fn.nr2char(63163)
map('n', '<leader>du', function() dap.step_out() end, {desc = " Step Out" })

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
        "scopes",
        "repl",
      },
      size = 0.25, -- 25% of total lines
      position = "bottom",
    },
    {
      elements = {
      -- Elements can be strings or table with id and size keys.
        "breakpoints",
        "stacks",
        "watches",
        -- "console",
      },
      size = 40, -- 40 columns
      position = "right",
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

