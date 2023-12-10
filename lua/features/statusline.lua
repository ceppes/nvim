local M = {}

M = {
  'feline-nvim/feline.nvim',
  config = function()
    require("features.statusline").setup()
  end
}


-- Colorscheme
local gruvbox = {
    fg = '#928374',
    bg = '#1F2223',
    black ='#1B1B1B',
    skyblue = '#458588',
    cyan = '#83a597',
    green = '#689d6a',
    oceanblue = '#1d2021',
    magenta = '#fb4934',
    orange = '#fabd2f',
    red = '#cc241d',
    violet = '#b16286',
    white = '#ebdbb2',
    yellow = '#d79921',
}


local vi_mode_text = {
    n = "NORMAL",
    i = "INSERT",
    v = "VISUAL",
    [''] = "V-BLOCK",
    V = "V-LINE",
    c = "COMMAND",
    no = "UNKNOWN",
    s = "UNKNOWN",
    S = "UNKNOWN",
    ic = "UNKNOWN",
    R = "REPLACE",
    Rv = "UNKNOWN",
    cv = "UNKWON",
    ce = "UNKNOWN",
    r = "REPLACE",
    rm = "UNKNOWN",
    t = "INSERT"
}

local function file_osinfo()
    local os = vim.bo.fileformat:upper()
    local icon
    if os == 'UNIX' then
        icon = ' '
    elseif os == 'MAC' then
        icon = ' '
    else
        icon = ' '
    end
    return icon .. os
end

local function composition()
  local lspproviders_status_ok, lsp = pcall(require, 'feline.providers.lsp')
  if not lspproviders_status_ok then
    return
  end

  local vimodeutils_status_ok, vi_mode_utils = pcall(require, 'feline.providers.vi_mode')
  if not vimodeutils_status_ok then
    return
  end
  -- local vi_mode_utils = require('feline.providers.vi_mode')
  -- local lsp = require('feline.providers.lsp')

  local clrs = require("catppuccin.palettes").get_palette()

  return {
    vi_mode = {
      left = {
        left_sep = "",
        right_sep = "",
        provider = function()
          return ' '..vi_mode_text[vim.fn.mode()]..' '
        end,
        hl = function()
          return {
            name = vi_mode_utils.get_mode_highlight_name(),
            bg = vi_mode_utils.get_mode_color(),
            fg = 'black',
            style = 'bold',
          }
        end
      },
      right = {
        provider = '▊',
        hl = function()
            return {
                name = vi_mode_utils.get_mode_highlight_name(),
                -- fg = vi_mode_utils.get_mode_color()
            }
        end,
        left_sep = ' '
      }
    },
    file = {
      info = {
        provider = {
          name = 'file_info',
          opts = {
              type = 'relative'
          }
        },
        short_provider = {
          name = 'file_info',
          opts = {
              type = 'relative-short'
          }
        },
        -- provider = require("plugins/feline/file_name").get_current_ufn,
          -- provider = vim.fn.expand("%:F"),
        hl = {
          -- fg = 'blue',
          style = 'bold'
        },
        left_sep = ' '
      },
      encoding = {
        provider = 'file_encoding',
        left_sep = ' ',
        hl = {
          -- fg = 'violet',
          style = 'bold'
        }
      },
      type = {
        provider = 'file_type'
      },
      os = {
        provider = file_osinfo,
        left_sep = ' ',
        hl = {
          -- fg = 'violet',
          style = 'bold'
        }
      },
      icon = {
        provider = function()
          local filename = vim.fn.expand('%:t')
          local extension = vim.fn.expand('%:e')
          local icon  = require'nvim-web-devicons'.get_icon(filename, extension)
          if icon == nil then
            icon = ''
          end
          return icon
        end,
        hl = function()
          local val = {}
          local filename = vim.fn.expand('%:t')
          local extension = vim.fn.expand('%:e')
          local icon, name  = require'nvim-web-devicons'.get_icon(filename, extension)
          -- if icon ~= nil then
            -- val.fg = vim.fn.synIDattr(vim.fn.hlID(name), 'fg')
          -- else
            -- val.fg = 'white'
          -- end
          -- val.bg = 'bg'
          val.style = 'bold'
          return val
        end,
        left_sep = ' '
      },
      size = {
        provider = 'file_size',
        enabled = function() return vim.fn.getfsize(vim.fn.expand('%:t')) > 0 end,
        hl = {
          -- fg = 'skyblue',
          -- bg = 'bg',
          style = 'bold'
        },
      },
      format = {
        provider = function() return '' .. vim.bo.fileformat:upper() .. '' end,
        hl = {
          -- fg = 'white',
          -- bg = 'bg',
          style = 'bold'
        },
      },
    },
    line_percentage = {
      provider = 'line_percentage',
      left_sep = ' ',
      hl = {
        style = 'bold'
      }
    },
    position = {
      name = 'line_number',
      provider = function()
        local cursor_row, cursor_col = unpack(vim.api.nvim_win_get_cursor(0))
        local line_count = vim.api.nvim_buf_line_count(0)
        return ' ' .. cursor_row .. '/' .. line_count .. ': ' .. cursor_col
      end,
      left_sep = ' ',
      hl = function()
        local val = {
          name = vi_mode_utils.get_mode_highlight_name(),
          -- fg = colors.bg,
          -- bg = vi_mode_utils.get_mode_color(),
          style = 'bold'
        }
        return val
      end
    },
   scroll_bar = {
      provider = 'scroll_bar',
      reverse = false, -- doesnt work
      left_sep = ' ',
      hl = {
        -- fg = 'blue',
        style = 'bold'
      }
    },
    diagnos = {
      err = {
        provider = 'diagnostic_errors',
        enabled = function()
          return lsp.diagnostics_exist(vim.diagnostic.severity.ERROR)
        end,
        hl = {
          fg = 'red'
        }
      },
      warn = {
        provider = 'diagnostic_warnings',
        enabled = function()
          return lsp.diagnostics_exist(vim.diagnostic.severity.WARN)
        end,
        hl = {
          fg = 'yellow'
        }
      },
      hint = {
        provider = 'diagnostic_hints',
        enabled = function()
          return lsp.diagnostics_exist(vim.diagnostic.severity.HINT)
        end,
        hl = {
          fg = 'cyan'
        }
      },
      info = {
        provider = 'diagnostic_info',
        enabled = function()
          return lsp.diagnostics_exist(vim.diagnostic.severity.INFO)
        end,
        hl = {
          fg = 'blue'
        }
      },
    },
    lsp = {
      name = {
        provider = 'lsp_client_names',
        truncate_hide = true,
        left_sep = ' ',
        icon = ' ',
        hl = {
          fg = 'yellow'
        }
      }
    },
    git = {
      branch = {
        left_sep = "",
        provider = 'git_branch',
        truncate_hide = true,
        icon = ' ',
        hl = {
          fg = clrs.lavender,
          bg = clrs.overlay1,
          style = 'bold'
        },
        enabled = function()
          return vim.b.gitsigns_status_dict ~= nil
        end,
      },
      add = {
        provider = 'git_diff_added',
        truncate_hide = true,
        hl = {
          fg = 'green',
          bg = clrs.overlay1,
        }
      },
      change = {
        provider = 'git_diff_changed',
        truncate_hide = true,
        hl = {
          fg = 'orange',
          bg = clrs.overlay1,
        }
      },
      remove = {
        provider = 'git_diff_removed',
        truncate_hide = true,
        right_sep = "",
        hl = {
          fg = 'red',
          bg = clrs.overlay1,
        }
      }
    }
  }
end

local active = function()
  local feline_status_ok, feline = pcall(require, 'feline')
  if not feline_status_ok then
    return
  end

  return {
  { -- left
    composition().vi_mode.left,
    -- composition().file.info,
    composition().diagnos.err,
    composition().diagnos.warn,
    composition().diagnos.hint,
    composition().diagnos.info
  },
  { -- mid

  },
  { -- right
    composition().git.branch,
    composition().git.add,
    composition().git.change,
    composition().git.remove,
    composition().file.icon,
    composition().lsp.name,
    -- M.composition().file.format
    -- M.composition().file.size,
    composition().file.encoding,
    composition().file.os,
    composition().line_percentage,
    composition().position,
    -- composition().scroll_bar,
    -- comps.vi_mode.right

  }
}
end

local inactive = function()
  local feline_status_ok, feline = pcall(require, 'feline')
  if not feline_status_ok then
    return
  end
  return {
  { -- left
    composition().file.info,
  },
  { -- mid

  },
  { -- right
    composition().file.os
  }
}
end

function M.setup()
  -- local feline = require 'feline'
  local feline_status_ok, feline = pcall(require, 'feline')
  if not feline_status_ok then
    return
  end

  local clrs = require("catppuccin.palettes").get_palette()

  feline.setup({
    components = {
      active = active(),
      inactive = inactive()
    },
    force_inactive = {
      filetypes = {
        'packer',
        'fugitive',
        'fugitiveblame'
      },
      buftypes = {'terminal'},
      bufnames = {}
    },
    mode_colors = {
      ["n"] = { "NORMAL", clrs.lavender },
      ["no"] = { "N-PENDING", clrs.lavender },
      ["i"] = { "INSERT", clrs.green },
      ["ic"] = { "INSERT", clrs.green },
      ["t"] = { "TERMINAL", clrs.green },
      ["v"] = { "VISUAL", clrs.flamingo },
      ["V"] = { "V-LINE", clrs.flamingo },
      ["�"] = { "V-BLOCK", clrs.flamingo },
      ["R"] = { "REPLACE", clrs.maroon },
      ["Rv"] = { "V-REPLACE", clrs.maroon },
      ["s"] = { "SELECT", clrs.maroon },
      ["S"] = { "S-LINE", clrs.maroon },
      ["�"] = { "S-BLOCK", clrs.maroon },
      ["c"] = { "COMMAND", clrs.peach },
      ["cv"] = { "COMMAND", clrs.peach },
      ["ce"] = { "COMMAND", clrs.peach },
      ["r"] = { "PROMPT", clrs.teal },
      ["rm"] = { "MORE", clrs.teal },
      ["r?"] = { "CONFIRM", clrs.mauve },
      ["!"] = { "SHELL", clrs.green },
    },
    -- theme = gruvbox
    -- default_bg = colors.bg,
    -- default_fg = colors.fg,
    -- properties = properties,
    -- vi_mode_colors = vi_mode_colors
  })
end


return M
