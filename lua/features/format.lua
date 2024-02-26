local M = {}

M = {
  "mhartington/formatter.nvim",
  config = function()
    require("features.format").setup()
    require("features.format").keymaps()
  end
}

function M.get_active_clients()
  -- Add formatters (from formatter.nvim)
  local buf_ft = vim.bo.filetype
  local buf_client_names_unique = {}

  local formatter_s, _ = pcall(require, "formatter")
  if formatter_s then
    local formatter_util = require("formatter.util")

    if #formatter_util.get_available_formatters_for_ft(buf_ft) == 0 then
      return {"No FMT"}
    end

    for _,j in ipairs(formatter_util.get_available_formatters_for_ft(buf_ft)) do
      for k,formatter_name in pairs(j) do
          if k == "exe" then
            buf_client_names_unique[formatter_name]= formatter_name
          end
      end
    end
  end

  local buf_client_names  = {}
  for _,v in pairs(buf_client_names_unique) do
      table.insert(buf_client_names, v)
  end
  return buf_client_names
end

function M.keymaps()
  vim.keymap.set('n', '<leader>f', ':Format<CR>', { desc = "Format" } )
end

function M.setup()
    local formatter = require("formatter")
    local formatter_util = require("formatter.util")
    local default_formatters = require("formatter.defaults")

    local formatter_ensure_installed = { 'prettierd', 'shfmt' }

    local filetype = {
      javascript = { require("formatter.filetypes.javascript").prettierd },
      javascriptreact = { require("formatter.filetypes.javascriptreact").prettierd },
      typescript = { require("formatter.filetypes.typescript").prettierd },
      typescriptreact = { require("formatter.filetypes.typescript").prettierd },
      python = {
        require("formatter.filetypes.python").black,
        require("formatter.filetypes.python").autopep8,
      },
      java = { require("formatter.filetypes.java").google_java_format },
      sh = { require("formatter.filetypes.sh").shfmt },
      lua = { require("formatter.filetypes.lua").stylua },
      ["*"] = {
        require("formatter.filetypes.any").remove_trailing_whitespace
      }
    }

    local servers = require("features.lspconfig.servers")
    for _, config in pairs(servers) do

      if config.formatter then
        print(config.formatter, type(config.formatter))
        if type(config.formatter) == "table" then
          for _,j in pairs(formatter_ensure_installed) do
            -- table.insert(formatter_ensure_installed, j)
            print(j, type(j))
          end
        else
          formatter_ensure_installed[config.formatter] = config.formatter
        end
      end

      if config.formatter and config.filetype then
        filetype[config.filetype] = { require("formatter.filetypes.typescript").formatter}
      end

    end

    for i,j in pairs(formatter_ensure_installed) do
      print("i: ", i, " j: ", j)
    end
    -- for i,j in pairs(filetype) do
    --   print("i: ", i, " j: ", j)
    -- end
    -- for k,v in pairs(formatters) do
    --   for i,j in pairs(v) do
    --     print(k, v, i, j)
    --   end
    -- end

    formatter.setup({
      logging = true,
      filetype = filetype
    })
end

return M


