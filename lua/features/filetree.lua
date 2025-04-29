local M = {}

M = {
  "nvim-neo-tree/neo-tree.nvim",
  -- branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  keys = {
    { "<leader>e", "<cmd>Neotree reveal position=float<cr>", desc = "File : NeoTree" },
    { "<leader>E", "<cmd>Neotree reveal position=left<cr>", desc = "File : NeoTree float" },
    { "<leader>EE", "<cmd>Neotree reveal position=current<cr>", desc = "File : NeoTree float" },
  },
  config = function()
    require("neo-tree").setup({
      filesystem = {
        filtered_items = {
          visible = true, -- This is what you want: If you set this to `true`, all "hide" just mean "dimmed out"
          hide_dotfiles = false,
          hide_gitignored = true,
        }
      },
      source_selector = {
        winbar = true,
        status = false,
        sources = {
          { source = "filesystem" },
          { source = "buffers" },
          { source = "git_status" },
          { source = "document_symbols" },
        },
      },
      sources = {
        "filesystem",
        "buffers",
        "git_status",
        "document_symbols",
      },
      buffers = {
        follow_current_file = {
          enabled = true,
        },
      },
    })
  end,
}

return M
