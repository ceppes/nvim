local M = {}

-- inspiration
--  require('catppuccin.groups.integrations.feline')
M = {
    "famiu/feline.nvim",
    event = "BufReadPre",
    dependencies = {
        "nvim-web-devicons",
        { "SmiteshP/nvim-navic" },
    },
    config = function()
        require("features.statusline").setup()
    end,
}

local function file_osinfo()
    local os = vim.bo.fileformat:upper()
    local icon
    if os == "UNIX" then
        icon = " "
    elseif os == "MAC" then
        icon = " "
    else
        icon = " "
    end
    return icon .. os
end

function M.setup()
    local C = require("catppuccin.palettes").get_palette()
    local navic = require("nvim-navic")

    local mode_colors = {
        ["n"] = { "NORMAL", C.lavender },
        ["no"] = { "N-PENDING", C.lavender },
        ["i"] = { "INSERT", C.green },
        ["ic"] = { "INSERT", C.green },
        ["t"] = { "TERMINAL", C.green },
        ["v"] = { "VISUAL", C.flamingo },
        ["V"] = { "V-LINE", C.flamingo },
        [""] = { "V-BLOCK", C.flamingo },
        ["R"] = { "REPLACE", C.maroon },
        ["Rv"] = { "V-REPLACE", C.maroon },
        ["s"] = { "SELECT", C.maroon },
        ["S"] = { "S-LINE", C.maroon },
        [""] = { "S-BLOCK", C.maroon },
        ["c"] = { "COMMAND", C.peach },
        ["cv"] = { "COMMAND", C.peach },
        ["ce"] = { "COMMAND", C.peach },
        ["r"] = { "PROMPT", C.teal },
        ["rm"] = { "MORE", C.teal },
        ["r?"] = { "CONFIRM", C.mauve },
        ["!"] = { "SHELL", C.green },
    }

    local assets = {
        left_separator = "",
        right_separator = "",
        mode_icon = "",
        dir = "󰉖",
        file = "󰈙",
        lsp = {
            server = "󰅡",
            error = "",
            warning = "",
            info = "",
            hint = "",
        },
        git = {
            branch = "",
            added = "",
            changed = "",
            removed = "",
        },
    }

    local sett = {
        text = C.mantle,
        bkg = C.mantle,
        diffs = C.mauve,
        extras = C.overlay1,
        curr_file = C.maroon,
        curr_dir = C.flamingo,
        show_modified = true,
    }

    if require("catppuccin").flavour == "latte" then
        local latte = require("catppuccin.palettes").get_palette("latte")
        sett.text = latte.base
        sett.bkg = latte.crust
    end

    if require("catppuccin").options.transparent_background then
        sett.bkg = "NONE"
    end

    local function composition()
        local lspproviders_status_ok, lsp = pcall(require, "feline.providers.lsp")
        if not lspproviders_status_ok then
            return
        end

        local vimodeutils_status_ok, vi_mode_utils = pcall(require, "feline.providers.vi_mode")
        if not vimodeutils_status_ok then
            return
        end

        local clrs = require("catppuccin.palettes").get_palette("latte")

        return {
            vi_mode = {
                left = {
                    left_sep = "",
                    right_sep = "",
                    provider = function()
                        return mode_colors[vim.fn.mode()][1] .. ""
                    end,
                    hl = function()
                        return {
                            fg = sett.text,
                            bg = mode_colors[vim.fn.mode()][2],
                            style = "bold",
                        }
                    end,
                },
            },
            file = {
                info_full = {
                    left_sep = " ",
                    provider = {
                        name = "file_info",
                        opts = {
                            type = "relative",
                        },
                    },
                    short_provider = {
                        name = "file_info",
                        opts = {
                            type = "relative-short",
                        },
                    },
                    hl = {
                        style = "bold",
                    },
                },
                info = {
                    left_sep = " ",
                    provider = {
                        name = "file_info",
                    },
                },
                encoding = {
                    provider = "file_encoding",
                    left_sep = " ",
                    hl = {
                        -- fg = 'violet',
                        style = "bold",
                    },
                },
                type = {
                    provider = "file_type",
                },
                os = {
                    provider = file_osinfo,
                    left_sep = " ",
                    hl = {
                        -- fg = 'violet',
                        style = "bold",
                    },
                },
                icon = {
                    provider = function()
                        local filename = vim.fn.expand("%:t")
                        local extension = vim.fn.expand("%:e")
                        local icon = require("nvim-web-devicons").get_icon(filename, extension)
                        if icon == nil then
                            icon = ""
                        end
                        return icon
                    end,
                    hl = function()
                        local val = {}
                        local filename = vim.fn.expand("%:t")
                        local extension = vim.fn.expand("%:e")
                        -- local icon, name  = require'nvim-web-devicons'.get_icon(filename, extension)
                        -- if icon ~= nil then
                        -- val.fg = vim.fn.synIDattr(vim.fn.hlID(name), 'fg')
                        -- else
                        -- val.fg = 'white'
                        -- end
                        -- val.bg = 'bg'
                        val.style = "bold"
                        return val
                    end,
                    left_sep = " ",
                },
                size = {
                    provider = "file_size",
                    enabled = function()
                        return vim.fn.getfsize(vim.fn.expand("%:t")) > 0
                    end,
                    hl = {
                        -- fg = 'skyblue',
                        -- bg = 'bg',
                        style = "bold",
                    },
                },
                format = {
                    provider = function()
                        return "" .. vim.bo.fileformat:upper() .. ""
                    end,
                    hl = {
                        -- fg = 'white',
                        -- bg = 'bg',
                        style = "bold",
                    },
                },
                navic = {
                    left_sep = " ",
                    provider = function()
                        return navic.get_location()
                    end,
                    enabled = function()
                        return navic.is_available()
                    end,
                },
            },
            line_percentage = {
                provider = "line_percentage",
                left_sep = " | ",
                hl = {
                    style = "bold",
                },
            },
            position = {
                name = "line_number",
                provider = function()
                    local cursor_row, cursor_col = unpack(vim.api.nvim_win_get_cursor(0))
                    local line_count = vim.api.nvim_buf_line_count(0)
                    return "" .. cursor_row .. "/" .. line_count .. ": " .. cursor_col
                end,
                left_sep = " ",
                hl = function()
                    local val = {
                        name = vi_mode_utils.get_mode_highlight_name(),
                        -- fg = colors.bg,
                        -- bg = vi_mode_utils.get_mode_color(),
                        style = "bold",
                    }
                    return val
                end,
            },
            scroll_bar = {
                provider = "scroll_bar",
                reverse = false, -- doesnt work
                left_sep = " ",
                hl = {
                    -- fg = 'blue',
                    style = "bold",
                },
            },
            diagnos = {
                err = {
                    provider = "diagnostic_errors",
                    enabled = function()
                        return lsp.diagnostics_exist(vim.diagnostic.severity.ERROR)
                    end,
                    hl = {
                        fg = clrs.red,
                    },
                },
                warn = {
                    provider = "diagnostic_warnings",
                    enabled = function()
                        return lsp.diagnostics_exist(vim.diagnostic.severity.WARN)
                    end,
                    hl = {
                        fg = clrs.yellow,
                    },
                },
                hint = {
                    provider = "diagnostic_hints",
                    enabled = function()
                        return lsp.diagnostics_exist(vim.diagnostic.severity.HINT)
                    end,
                    hl = {
                        fg = clrs.blue,
                    },
                },
                info = {
                    provider = "diagnostic_info",
                    enabled = function()
                        return lsp.diagnostics_exist(vim.diagnostic.severity.INFO)
                    end,
                    hl = {
                        fg = clrs.blue,
                    },
                },
            },
            lsp = {
                name = {
                    provider = "lsp_client_names",
                    truncate_hide = true,
                    left_sep = " ",
                    icon = " ",
                    hl = {
                        fg = clrs.yellow,
                    },
                },
            },
            nullls = {
                name = {
                    left_sep = " ",
                    hl = {
                        fg = clrs.blue,
                    },
                    provider = function()
                        return table.concat(require("features.null-ls").get_active_clients(), ", ")
                    end,
                },
            },
            lint = {
                name = {
                    provider = function()
                        return table.concat(require("features.lint").get_active_clients(), ", ")
                    end,
                    left_sep = " ",
                    truncate_hide = true,
                    hl = {
                        fg = clrs.peach,
                    },
                },
            },
            format = {
                name = {
                    provider = function()
                        return table.concat(require("features.format").get_active_clients(), ", ")
                    end,
                    left_sep = " ",
                    hl = {
                        fg = clrs.blue,
                    },
                },
            },
            git = {
                branch = {
                    left_sep = "",
                    provider = "git_branch",
                    truncate_hide = true,
                    icon = " ",
                    hl = {
                        bg = clrs.subtext0,
                        style = "bold",
                    },
                    enabled = function()
                        return vim.b.gitsigns_status_dict ~= nil
                    end,
                },
                add = {
                    provider = "git_diff_added",
                    truncate_hide = true,
                    hl = {
                        fg = clrs.green,
                        bg = clrs.subtext0,
                    },
                },
                change = {
                    provider = "git_diff_changed",
                    truncate_hide = true,
                    hl = {
                        fg = clrs.maroon,
                        bg = clrs.subtext0,
                    },
                },
                remove = {
                    provider = "git_diff_removed",
                    truncate_hide = true,
                    hl = {
                        fg = clrs.red,
                        bg = clrs.subtext0,
                    },
                },
                sep = {
                    provider = " ",
                    right_sep = "",
                    hl = {
                        bg = clrs.subtext0,
                    },
                },
            },
            search_count = {
                provider = "search_count",
                enabled = function()
                    return vim.api.nvim_get_option("cmdheight") == 0
                end,
                left_sep = " ",
                hl = {
                    fg = clrs.green,
                },
            },
        }
    end

    local active = function()
        return {
            { -- left
                composition().vi_mode.left,
                composition().diagnos.err,
                composition().diagnos.warn,
                composition().diagnos.hint,
                composition().diagnos.info,
                composition().file.info,
            },
            { -- mid
            },
            { -- right
                composition().git.branch,
                composition().git.add,
                composition().git.change,
                composition().git.remove,
                composition().git.sep,
                -- composition().file.icon,
                composition().lsp.name,
                -- composition().nullls.name,
                composition().lint.name,
                composition().format.name,
                composition().search_count,
                -- composition().file.format,
                -- composition().file.size,
                composition().file.encoding,
                composition().file.os,
                -- composition().line_percentage,
                composition().position,
                -- composition().scroll_bar,
            },
        }
    end

    local inactive = function()
        return {
            { -- left
                composition().file.info,
            },
            { -- mid
            },
            { -- right
                -- composition().file.os
                composition().position,
            },
        }
    end

    require("feline").setup({
        components = {
            active = active(),
            inactive = inactive(),
        },
        force_inactive = {
            filetypes = {
                "fugitive",
                "fugitiveblame",
            },
            buftypes = { "terminal" },
            bufnames = {},
        },
        assets = assets,
        sett = sett,
        mode_colors = mode_colors,
    })
end

return M
