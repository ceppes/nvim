-- Remap some commands that I often get wrong
vim.api.nvim_create_user_command('Qa', 'qa', { nargs = 0 })
vim.api.nvim_create_user_command('Q', 'q', { nargs = 0 })
vim.api.nvim_create_user_command('Wa', 'wa', { nargs = 0 })
vim.api.nvim_create_user_command('Wq', 'wq', { nargs = 0 })

vim.api.nvim_create_user_command('FT', function ()
  print(vim.bo.filetype)
end, { nargs = 0, desc = 'Print filetype' })
