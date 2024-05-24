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

    local formatter_ensure_installed = {}
    formatter_ensure_installed['prettierd'] = 1
    formatter_ensure_installed['shfmt'] = 1

    local filetype = {
      javascript = { require("formatter.filetypes.javascript").prettierd },
      javascriptreact = { require("formatter.filetypes.javascriptreact").prettierd },
      typescript = { require("formatter.filetypes.typescript").prettierd },
      typescriptreact = { require("formatter.filetypes.typescript").prettierd },
      xml = {require("formatter.filetypes.xml").xmlformat },
      python = {
        require("formatter.filetypes.python").black,
        require("formatter.filetypes.python").autopep8,
      },
      java = { require("formatter.filetypes.java").google_java_format },
      sh = {
        function ()
          -- require("formatter.filetypes.sh").shfmt },
          local shiftwidth = vim.opt.shiftwidth:get()
          local expandtab = vim.opt.expandtab:get()

          if not expandtab then
            shiftwidth = 0
          end
          -- "-i", shiftwidth,
          return {
            exe = "shfmt",
            args = {
              "--diff",
              "--indent",
              "2",
              "--case-indent"},
            stdin = true,
          }
        end
        },
      lua = { require("formatter.filetypes.lua").stylua },
      ["*"] = {
        require("formatter.filetypes.any").remove_trailing_whitespace
      }
    }
    -- filetype = {}

    local servers = require("features.lspconfig.servers")
    for _, config in pairs(servers) do

      if config.formatter then
        -- print("formatter", config.formatter, type(config.formatter))
        if type(config.formatter) == "table" then
          for _,j in pairs(config.formatter) do
            formatter_ensure_installed[j] = j
            -- print("j: ", j, type(j))
          end
        else
          formatter_ensure_installed[config.formatter] = config.formatter
        end
      end

      -- if config.formatter and config.filetype then
      --   if type(config.formatter) == "table" then
      --     -- local current = {}
      --     for _,j in pairs(config.formatter) do
      --       table.insert(filetype[config.filetype],  require("formatter.filetypes.typescript").formatter)
      --     end
      --   else
      --     filetype[config.filetype] = { require("formatter.filetypes.typescript").formatter}
      --   end
      -- end
      --
    end
    local formatter_ensure_installed2 = {}
    for i,j in pairs(formatter_ensure_installed) do
      -- print("i: ", i, " j: ", j)
      table.insert(formatter_ensure_installed2, i)
    end
    -- for i,j in pairs(filetype) do
    --   print("i: ", i, " j: ", j)
    -- end

    -- for i,j in pairs(filetype) do
    --   print("i: ", i, " j: ", j)
    --   for k,v in pairs(j) do
    --     print("     k:", k,"v: ",  v)
    --   end
    -- end

    formatter.setup({
      logging = true,
      filetype = filetype
    })
end

return M

