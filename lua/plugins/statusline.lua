----------------------------------------------------------
-- Statusline configuration file
-----------------------------------------------------------

local feline = require 'feline'

-- Colorscheme
--local colors = require('')

-- Providers
local lsp = require 'feline.providers.lsp'
local vi_mode_utils = require 'feline.providers.vi_mode'
require 'gitsigns'.setup{}

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

local my_comps = {
  vi_mode = {
    left = {
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
              fg = vi_mode_utils.get_mode_color()
          }
      end,
      left_sep = ' '
    }
  },
  file = {
    info = {
      provider = 'file_info',
      -- provider = require("plugins/feline/file_name").get_current_ufn,
        -- return vim.fn.expand("%:F")
      hl = {
        fg = 'blue',
        style = 'bold'
      },
      left_sep = ' '
    },
    encoding = {
      provider = 'file_encoding',
      left_sep = ' ',
      hl = {
        fg = 'violet',
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
        fg = 'violet',
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
        if icon ~= nil then
          val.fg = vim.fn.synIDattr(vim.fn.hlID(name), 'fg')
        else
          val.fg = 'white'
        end
        val.bg = 'bg'
        val.style = 'bold'
        return val
      end,
      left_sep = ' '
    },
    size = {
      provider = 'file_size',
      enabled = function() return vim.fn.getfsize(vim.fn.expand('%:t')) > 0 end,
      hl = {
        fg = 'skyblue',
        bg = 'bg',
        style = 'bold'
      },
    },
    format = {
      provider = function() return '' .. vim.bo.fileformat:upper() .. '' end,
      hl = {
        fg = 'white',
        bg = 'bg',
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
    position = 'position',
    -- provider = function()
      -- pos = feline.providers.cursor.position()
      -- return ' '..pos..' '
    -- end,
    left_sep = ' ',
    hl = function()
      local val = {
        name = vi_mode_utils.get_mode_highlight_name(),
        -- fg = colors.bg,
        bg = vi_mode_utils.get_mode_color(),
        style = 'bold'
      }
      return val
    end
  },
 scroll_bar = {
    provider = 'scroll_bar',
    left_sep = ' ',
    hl = {
      fg = 'blue',
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
      left_sep = ' ',
      icon = ' ',
      hl = {
        fg = 'yellow'
      }
    }
  },
  git = {
    branch = {
      provider = 'git_branch',
      icon = ' ',
      left_sep = ' ',
      hl = {
        fg = 'violet',
        style = 'bold'
      },
      enabled = function()
        return vim.b.gitsigns_status_dict ~= nil
      end,
    },
    add = {
      provider = 'git_diff_added',
      hl = {
        fg = 'green'
      }
    },
    change = {
      provider = 'git_diff_changed',
      hl = {
        fg = 'orange'
      }
    },
    remove = {
      provider = 'git_diff_removed',
      hl = {
        fg = 'red'
      }
    }
  }
}

local active = {
  { -- left
    my_comps.vi_mode.left,
    my_comps.file.info,
    my_comps.diagnos.err,
    my_comps.diagnos.warn,
    my_comps.diagnos.hint,
    my_comps.diagnos.info
  },
  { -- mid

  },
  { -- right
    my_comps.git.branch,
    my_comps.git.add,
    my_comps.git.change,
    my_comps.git.remove,
    my_comps.file.icon,
    my_comps.lsp.name,
    -- my_comps.file.format
    -- my_comps.file.size,
    my_comps.file.encoding,
    my_comps.file.os,
    my_comps.scroll_bar,
    my_comps.line_percentage,
    -- comps.vi_mode.right
    my_comps.position,

  }
}

local inactive = {
  { -- left
    my_comps.file.info,
  },
  { -- mid

  },
  { -- right
    my_comps.file.os
  }
}

feline.setup({
  components = {
    active = active,
    inactive = inactive
  },
  force_inactive = {
    filetypes = {
      'packer',
      'fugitive',
      'fugitiveblame'
    },
    buftypes = {'terminal'},
    bufnames = {}
  }
  -- default_bg = colors.bg,
  -- default_fg = colors.fg,
  -- properties = properties,
  -- vi_mode_colors = vi_mode_colors
})

