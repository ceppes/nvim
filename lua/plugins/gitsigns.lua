require("gitsigns").setup({
  signs = {
    add          = { hl = "GitSignsAdd"   , text = "▋" },
    change       = { hl = "GitSignsChange", text = "▋" },
    delete       = { hl = "GitSignsDelete", text = "▁ " },
    topdelete    = { hl = "GitSignsDelete", text = "▔" },
    changedelete = { hl = "GitSignsChange", text = "▎" },
  },
  current_line_blame = true,
  current_line_blame_opts = {
    delay = 0,
  },
  sign_priority=0 -- for column
})
