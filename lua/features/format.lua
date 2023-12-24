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
  local buf_client_names = {}

  local formatter_s, _ = pcall(require, "formatter")
  if formatter_s then
    local formatter_util = require("formatter.util")
    if #formatter_util.get_available_formatters_for_ft(buf_ft) == 0 then
      return {"F̶m̶t̶"}
    end
    for _, formatter in ipairs(formatter_util.get_available_formatters_for_ft(buf_ft)) do
      if formatter then
        table.insert(buf_client_names, formatter)
      end
    end
  end
  return buf_client_names
end

function M.keymaps()
  vim.keymap.set('n', '<leader>f', ':Format<CR>', { desc = "Format" } )
end

function M.setup()
    local formatter = require("formatter")
    local default_formatters = require("formatter.defaults")
    local prettierd = default_formatters.prettierd
    local stylua = default_formatters.stylua
    local black = default_formatters.black

    local formatter_ensure_installed = { 'prettierd' }

    local formatters = {
      javascript = { prettierd },
      javascriptreact = { prettierd },
      typescript = { prettierd },
      typescriptreact = { prettierd },
      python = { black }

    }

    local servers = require("features.lspconfig.servers")
    for _, config in pairs(servers) do
      if config.formatter then
        table.insert(formatter_ensure_installed, config.formatter)
      end
      if config.formatter and config.filetype then
        formatters[config.filetype] = {config.formatter}
      end
    end
    -- for k,v in pairs(formatters) do
    --   for i,j in pairs(v) do
    --     print(k, v, i, j)
    --   end
    -- end

    formatter.setup({
      filetype = formatters
    })
end

return M
