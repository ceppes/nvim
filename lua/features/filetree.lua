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

        -- Get the default renderers and modify them
        local default_config = require("neo-tree.defaults")
        local file_renderer = vim.deepcopy(default_config.renderers.file)

        -- Find the position of file_size and insert line_count before it for files
        local file_content = file_renderer[3].content
        for i, component in ipairs(file_content) do
            if component[1] == "file_size" then
                table.insert(file_content, i, { "line_count", zindex = 10, align = "right" })
                break
            end
        end

        require("neo-tree").setup({
            filesystem = {
                components = {
                    name = function(config, node, state)
                        local original_name = require("neo-tree.sources.filesystem.components").name
                        local name_result = original_name(config, node, state)

                        if node.type == "directory" then
                            local path = node:get_id()
                            local success, count = pcall(function()
                                local handle = vim.loop.fs_scandir(path)
                                if not handle then return "?" end
                                local total = 0
                                while true do
                                    local name = vim.loop.fs_scandir_next(handle)
                                    if not name then break end
                                    if name ~= "." and name ~= ".." then
                                        total = total + 1
                                    end
                                end
                                return tostring(total)
                            end)
                            local count_text = ""
                            if success then
                                local num_count = tonumber(count)
                                if num_count > 1 then
                                    count_text = " (" .. count .. ")"
                                end
                            else
                                count_text = " (?)"
                            end
                            return {
                                text = name_result.text .. count_text,
                                highlight = name_result.highlight,
                            }
                        else
                            return name_result
                        end
                    end,
                    line_count = function(config, node, state)
                        if node.type == "file" then
                            local path = node:get_id()
                            local success, lines = pcall(function()
                                local file = io.open(path, "r")
                                if not file then return "?" end
                                local count = 0
                                for _ in file:lines() do
                                    count = count + 1
                                end
                                file:close()
                                return tostring(count)
                            end)
                            -- Fixed width formatting - pad to 8 characters (for up to 9999l)
                            local line_text = success and " " .. string.format("%4s", lines) .. " l" or "    ?l"

                            -- Color based on line count
                            local highlight = "NeoTreeDimText"
                            if success then
                                local line_count = tonumber(lines)
                                if line_count >= 1000 then
                                    highlight = "DiagnosticError"  -- Red for 1000+ lines
                                elseif line_count >= 500 then
                                    highlight = "DiagnosticWarn"   -- Yellow for 500+ lines
                                end
                            end

                            return {
                                text = line_text,
                                highlight = highlight,
                            }
                        else
                            return {
                                text = "     ",  -- 5 spaces to maintain alignment
                                highlight = "NeoTreeDimText",
                            }
                        end
                    end,
                },
                renderers = {
                    file = file_renderer,
                },
                filtered_items = {
                    visible = true, -- This is what you want: If you set this to `true`, all "hide" just mean "dimmed out"
                    hide_dotfiles = false,
                    hide_gitignored = true,
                },
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
            event_handlers = {
                {
                    event = "neo_tree_buffer_enter",
                    handler = function()
                        vim.cmd([[
                          setlocal relativenumber
                        ]])
                    end,
                },
            },
        })
    end,
}

return M
