local M = {}

M = {
  'goolord/alpha-nvim',
  config = function()
    require("features.welcome").setup()
  end
}

local header_pacman = {
    [[                                                                              ]],
    [[                                    ██████                                    ]],
    [[                                ████▒▒▒▒▒▒████                                ]],
    [[                              ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                              ]],
    [[                            ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                            ]],
    [[                          ██▒▒▒▒▒▒▒▒    ▒▒▒▒▒▒▒▒                              ]],
    [[                          ██▒▒▒▒▒▒  ▒▒▓▓▒▒▒▒▒▒  ▓▓▓▓                          ]],
    [[                          ██▒▒▒▒▒▒  ▒▒▓▓▒▒▒▒▒▒  ▒▒▓▓                          ]],
    [[                        ██▒▒▒▒▒▒▒▒▒▒    ▒▒▒▒▒▒▒▒    ██                        ]],
    [[                        ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                        ]],
    [[                        ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                        ]],
    [[                        ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                        ]],
    [[                        ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██                        ]],
    [[                        ██▒▒██▒▒▒▒▒▒██▒▒▒▒▒▒▒▒██▒▒▒▒██                        ]],
    [[                        ████  ██▒▒██  ██▒▒▒▒██  ██▒▒██                        ]],
    [[                        ██      ██      ████      ████                        ]],
    [[                                                                              ]],
    [[                                                                              ]]
  }
local header_neovim = {
  "                                                     ",
  "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
  "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
  "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
  "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
  "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
  "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
  "                                                     ",
}

function M.setup()
  local alpha_status_ok, alpha = pcall(require, 'alpha')
  if not alpha_status_ok then
    return
  end

  local dashboard = require("alpha.themes.dashboard")
  require("alpha.term")

  local terminal = {
    type = "terminal",
    command = vim.fn.expand("$HOME") .. "/.config/nvim/lua/features/thisisfine.sh",
    width = 46,
    height = 25,
    opts = {
      redraw = true,
      window_config = {}
    }
  }

  local header = {
      type = "text",
      -- val = header_pacman,
      val = header_neovim,
      opts = {
          position = "center",
          hl = "Type",
          -- wrap = "overflow";
      },
  }

  local footer = {
      type = "text",
      val = function()
        local platform = vim.fn.has "win32" == 1 and " " or " "

        local version = " " .. vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch

        local plugins_count = "   ?? Plugins"
        if require("lazy").plugins() ~= nil then
          plugins_count = "   " .. #vim.tbl_keys(require("lazy").plugins()) .. " Plugins"
        end
        local datetime = os.date "  %d-%m-%Y  %H:%M:%S"

        return platform .. version .. plugins_count .. datetime
      end,
      opts = {
          position = "center",
          hl = "Number",
      },
  }

  local buttons = {
      type = "group",
      val = {
          dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
          dashboard.button("f f", "  Find File", ":Telescope find_files<CR>"),
          dashboard.button("r", "󰊄  Recently opened files", ":Telescope oldfiles<CR>"),
          dashboard.button("f l", "󰈬  Find Word", ":Telescope live_grep<CR>"),
          dashboard.button("l", " Load last session current dir", ":SessionManager load_current_dir_session<CR>"),
          dashboard.button("u", "  Open Lazy", ":Lazy<CR>"),
          dashboard.button("q", " Quit", ":qa!<CR>"),
          -- dashboard.button("SPC f r", "  Frecency/MRU"),
          -- dashboard.button("c", "  Configuration", ":e $MYVIMRC<CR>"),
          -- dashboard.button("SPC f m", "  Jump to bookmarks"),
      },
      opts = {
          spacing = 1,
      },
  }

  local section = {
      terminal = terminal,
      header = header,
      buttons = buttons,
      footer = footer,
  }

  local marginTopPercent = 0.225
  local headerPadding = vim.fn.max {4, vim.fn.floor(vim.fn.winheight(0) * marginTopPercent)}

  local config = {
    layout = {
    { type = "padding", val = headerPadding },
    section.terminal,
    { type = "padding", val = 2 },
    -- section.header,
    { type = "padding", val = 2 },
    -- section.buttons,
    section.footer,
    },
    opts = {
      margin = 5,
    }
  }

  alpha.setup(config)
end

return M
-- https://github.com/mobily/.nvim/blob/main/lua/lazy/plugins.lua
