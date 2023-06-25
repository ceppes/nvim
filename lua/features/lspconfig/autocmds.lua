  -- Show line diagnostics automatically in hover window
  vim.cmd([[
    autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, { focus = false })
  ]])
