local alpha_status_ok, alpha = pcall(require, 'alpha')
if not alpha_status_ok then
  return
end

local dashboard = require 'alpha.themes.dashboard'
dashboard.section.header.val = {
  'header'
}

dashboard.section.buttons.val = {
  dashboard.button("f", "  Find File", ":Telescope find_files<CR>"),
  dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
  dashboard.button("r", "  Recent Files", ":Telescope oldfiles<CR>"),
  dashboard.button("t", "  Find Text", ":Telescope live_grep<CR>"),
  -- dashboard.button("c", "  Configuration", ":e $MYVIMRC<CR>"),
  dashboard.button("u", "  Update Plugins", ":PackerSync<CR>"),
  dashboard.button("q", "  Quit", ":qa!<CR>"),
}

local footer = function()
  local platform = vim.fn.has "win32" == 1 and " " or " "
  local version = " " .. vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch
  local plugins_count = "   ?? Plugins"
  if packer_plugins ~= nil then
    plugins_count = "   " .. #vim.tbl_keys(packer_plugins) .. " Plugins"
  end
  local datetime = os.date "  %d-%m-%Y  %H:%M:%S"

  return platform .. version .. plugins_count .. datetime
end
dashboard.section.footer.val = footer()

-- -- dashboard.section.footer.opts.hl = "AlphaFooter"
-- -- dashboard.section.header.opts.hl = "AlphaHeader"
-- -- dashboard.section.buttons.opts.hl = "AlphaButton"
-- -- dashboard.opts.opts.noautocmd = true
alpha.setup(dashboard.opts)
