local M = {}

local dap_ensure_installed = {
  'debugpy',
}

M = {
  'mfussenegger/nvim-dap',
  -- opt = true,
  -- event = "BufReadPre",
  -- module = {
  --   "dap"
  -- },
  dependencies = {
    -- "Pocco81/DAPInstall.nvim",
    "theHamsta/nvim-dap-virtual-text",
    "rcarriga/nvim-dap-ui",
    "mfussenegger/nvim-dap-python",
    "nvim-telescope/telescope-dap.nvim",
    -- { "leoluz/nvim-dap-go", module = "dap-go" },
    -- { "jbyuki/one-small-step-for-vimkind", module = "osv" },
    "jbyuki/one-small-step-for-vimkind",
  },
  config = function()
    require("features.debugger").setup()
    require("features.debugger").keymaps()
  end
}


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

local function require_check()
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

  return dap, dapui, dap_virtual_text, which_key
end

function M.setup()
  local dap, dapui, dap_virtual_text = require_check()
  if not dap or not dapui or not dap_virtual_text then
    return
  end

  vim.fn.sign_define("DapBreakpoint", dap_breakpoint.error)
  vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)
  vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.rejected)

  dap_virtual_text.setup{
    commented = true,
  }

  -- open, close and toggle the windows
  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
  end
  -- dap.listeners.before.event_terminated["dapui_config"] = function()
  --   dapui.close()
  -- end
  -- dap.listeners.before.event_exited["dapui_config"] = function()
  --   dapui.close()
  -- end

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

  local servers = {
    python = require('features.languages.python').debugger(),
  }

  for server, config in pairs(servers) do
    if config then
      config.dap[server].setup(config)
    end
  end
end

function M.keymaps()
  local dap, dapui, dap_virtual_text, which_key= require_check()
  if not dap or not dapui or not dap_virtual_text or not which_key then
    return
  end

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

  -- require("config.dap.keymaps").setup()
  vim.keymap.set('n', '<leader>db', function() dap.step_back() end, {desc = " Step Back" })
  vim.keymap.set('n', '<leader>dt', function() dap.toggle_breakpoint() end, {desc = "Toggle Breakpoint" }) -- local icon = vim.fn.nr2char(61453)
  vim.keymap.set('n', '<leader>dg', function() dap.session() end, {desc = "Get Session" })
  vim.keymap.set('n', '<leader>di', function() dap.step_into() end, {desc = " Step Into"}) -- local icon = vim.fn.nr2char(63162)
  vim.keymap.set('n', '<leader>do', function() dap.step_over() end, {desc = " Step Over" }) -- local icon = vim.fn.nr2char(63164)
  vim.keymap.set('n', '<leader>du', function() dap.step_out() end, {desc = " Step Out" }) -- local icon = vim.fn.nr2char(63163)

  vim.keymap.set('n', '<leader>dR', function() dap.run_to_cursor() end, {desc = "Run to Cursor"})
  vim.keymap.set('n', '<leader>dc', function() dap.continue() end, {desc = " Continue" })
  vim.keymap.set('n', '<leader>ds', function() dap.continue() end, {desc = " Start" }) -- local icon = vim.fn.nr2char(61515)
  vim.keymap.set('n', '<leader>dd', function() dap.disconnect() end, {desc = "□ Disconnect" })
  vim.keymap.set('n', '<leader>dx', function() dap.terminate() end, {desc = "□ Terminate" })
  vim.keymap.set('n', '<leader>dq', function() dap.close() end, {desc = "Quit" })

  vim.keymap.set('n', '<leader>dp', function() dap.pause.toggle() end, {desc = " Pause" }) -- local icon = vim.fn.nr2char(63715)
  vim.keymap.set('n', '<leader>dr', function() dap.repl.toggle() end, {desc = "Toggle Repl" })

  vim.keymap.set('n', '<leader>dU', function() dapui.toggle() end, {desc = "Toggle UI" })
  vim.keymap.set('n', '<leader>dE', function() dapui.eval(vim.fn.input '[Expression] > ') end, {desc = "Evaluate Input"})

  vim.keymap.set('n', '<leader>de', function() dapui.eval() end, {desc = "Evaluate" })
  vim.keymap.set('v', '<leader>de', function() dapui.eval() end, {desc = "Evaluate" })

  vim.keymap.set('n', '<leader>dh', function() dap.ui.widgets.hover() end, {desc = "Hover Variables" })
  vim.keymap.set('n', '<leader>dS', function() dap.ui.widgets.scopes() end, {desc = "Scopes" })


  -- Telescope dap conf
  which_key.register({
    dT = {
      name = "Telescope",
    }
  }, {
    mode = "n",
    prefix = "<leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = false,
  })
  require('telescope').load_extension('dap')
  -- vim.keymap.set('n', '<leader>dTc', require'telescope'.extensions.dap.configurations{}, {desc = "Telescope config" })
  vim.keymap.set('n', '<leader>dTc', "<cmd> lua require'telescope'.extensions.dap.configurations{}<cr>", {desc = "Telescope config" })

  vim.keymap.set('n', '<leader>dTb', "<cmd> lua require'telescope'.extensions.dap.list_breakpoints{}<cr>", {desc = "Telescope list breakpoints" })
  vim.keymap.set('n', '<leader>dTl', "<cmd> lua require'telescope'.extensions.dap.commands{}<cr>", {desc = "Telescope commands" })

end


return M
