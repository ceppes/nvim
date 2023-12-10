local M = {}

function M.setup()
  local severities = {
    [vim.diagnostic.severity.ERROR] = { text = "Error", sign = '' },
    [vim.diagnostic.severity.WARN] = { text = "Warn", sign = '' },
    [vim.diagnostic.severity.INFO] = { text = "Info", sign = '' },
    [vim.diagnostic.severity.HINT] = { text = "Hint", sign = '' },
  }

  for _, severity in pairs(severities) do
    local hl = ("DiagnosticSign%s"):format(severity.text)
    vim.fn.sign_define(hl, { text = severity.sign, texthl = hl, numhl = "" })
  end

  vim.diagnostic.config({
      underline = {
        severity_limit = 'Warning'
      },
      virtual_text = {
        prefix = '●',
        spacing = 2, --4
        severity_linit = "Warning"
      },
      signs = {
        severity_limit = 'Warning'
      },
      update_in_insert = true,
      virtual_lines = false,
      severity_sort = true
    }
  )
end

return M
