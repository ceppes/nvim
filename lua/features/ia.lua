local M

M = {
    "robitx/gp.nvim",
    cmd = { "GpChatNew", "GpExplain", "GpCommand" },
    config = function()
        local conf = {
            providers = {
                openai = {
                    endpoint = "https://api.openai.com/v1/chat/completions",
                    secret = os.getenv("OPENAI_API_KEY"),
                },
                ollama = {
                    endpoint = "http://localhost:11434/v1/chat/completions",
                },
            },
            agents = {
                -- {
                --     name = "ExampleDisabledAgent",
                --     disable = true,
                -- },
                {
                    name = "ChatGPT4o",
                    chat = true,
                    command = false,
                    -- string with model name or table with model name and parameters
                    model = { model = "gpt-4o", temperature = 1.1, top_p = 1 },
                    -- system prompt (use this to specify the persona/role of the AI)
                    system_prompt = require("gp.defaults").chat_system_prompt,
                },
                {
                    provider = "openai",
                    name = "ChatGPT4o-mini",
                    chat = true,
                    command = false,
                    -- string with model name or table with model name and parameters
                    model = { model = "gpt-4o-mini", temperature = 1.1, top_p = 1 },
                    -- system prompt (use this to specify the persona/role of the AI)
                    system_prompt = require("gp.defaults").chat_system_prompt,
                },
                {
                    provider = "openai",
                    name = "ChatGPT-o3-mini",
                    chat = true,
                    command = false,
                    -- string with model name or table with model name and parameters
                    model = { model = "o3-mini", temperature = 1.1, top_p = 1 },
                    -- system prompt (use this to specify the persona/role of the AI)
                    system_prompt = require("gp.defaults").chat_system_prompt,
                },
                {
                    provider = "openai",
                    name = "CodeGPT4o",
                    chat = false,
                    command = true,
                    -- string with model name or table with model name and parameters
                    model = { model = "gpt-4o", temperature = 0.8, top_p = 1 },
                    -- system prompt (use this to specify the persona/role of the AI)
                    system_prompt = require("gp.defaults").code_system_prompt,
                },
                {
                    provider = "openai",
                    name = "CodeGPT-o3-mini",
                    chat = false,
                    command = true,
                    -- string with model name or table with model name and parameters
                    model = { model = "o3-mini", temperature = 0.8, top_p = 1 },
                    -- system prompt (use this to specify the persona/role of the AI)
                    system_prompt = require("gp.defaults").code_system_prompt,
                },
                {
                    provider = "openai",
                    name = "CodeGPT4o-mini",
                    chat = false,
                    command = true,
                    -- string with model name or table with model name and parameters
                    model = { model = "gpt-4o-mini", temperature = 0.7, top_p = 1 },
                    -- system prompt (use this to specify the persona/role of the AI)
                    system_prompt = "Please return ONLY code snippets.\nSTART AND END YOUR ANSWER WITH:\n\n```",
                },
                {
                    provider = "ollama",
                    name = "ChatOllamaLlama3.1-8B",
                    chat = true,
                    command = false,
                    -- string with model name or table with model name and parameters
                    model = {
                        model = "llama3.1",
                        temperature = 0.6,
                        top_p = 1,
                        min_p = 0.05,
                    },
                    -- system prompt (use this to specify the persona/role of the AI)
                    system_prompt = "You are a general AI assistant.",
                },
                {
                    provider = "ollama",
                    name = "CodeOllamaLlama3.1-8B",
                    chat = false,
                    command = true,
                    -- string with model name or table with model name and parameters
                    model = {
                        model = "llama3.1",
                        temperature = 0.4,
                        top_p = 1,
                        min_p = 0.05,
                    },
                    -- system prompt (use this to specify the persona/role of the AI)
                    system_prompt = require("gp.defaults").code_system_prompt,
                },
                {
                    provider = "ollama",
                    name = "DS-Coder",
                    chat = "ollama",
                    command = true,
                    -- string with model name or table with model name and parameters
                    model = {
                        model = "deepseek-coder:6.7b",
                        temperature = 0.4,
                        top_p = 1,
                        min_p = 0.05,
                    },
                    -- system prompt (use this to specify the persona/role of the AI)
                    system_prompt = require("gp.defaults").code_system_prompt,
                },
                {
                    provider = "ollama",
                    name = "phi",
                    chat = "ollama",
                    command = true,
                    model = {
                        model = "phi",
                        temperature = 0.4,
                        top_p = 1,
                        min_p = 0.05,
                    },
                    system_prompt = require("gp.defaults").code_system_prompt,
                },
            },
        }
        require("gp").setup(conf)

        -- Setup shortcuts here (see Usage > Shortcuts in the Documentation/Readme)

        local function keymapOptions(desc)
            return {
                noremap = true,
                silent = true,
                nowait = true,
                desc = "IA " .. desc,
            }
        end

        -- Chat commands
        vim.keymap.set({ "n" }, "<leader>ic", "<cmd>GpChatNew<cr>", keymapOptions("New Chat"))
        vim.keymap.set({ "n" }, "<leader>it", "<cmd>GpChatToggle<cr>", keymapOptions("Toggle Chat"))
        vim.keymap.set({ "n" }, "<leader>if", "<cmd>GpChatFinder<cr>", keymapOptions("Chat Finder"))

        vim.keymap.set("v", "<leader>ic", ":<C-u>'<,'>GpChatNew<cr>", keymapOptions("Visual Chat New"))
        vim.keymap.set("v", "<leader>ip", ":<C-u>'<,'>GpChatPaste<cr>", keymapOptions("Visual Chat Paste"))
        vim.keymap.set("v", "<leader>it", ":<C-u>'<,'>GpChatToggle<cr>", keymapOptions("Visual Toggle Chat"))

        vim.keymap.set({ "n" }, "<leader>i<C-x>", "<cmd>GpChatNew split<cr>", keymapOptions("New Chat split"))
        vim.keymap.set({ "n" }, "<leader>i<C-v>", "<cmd>GpChatNew vsplit<cr>", keymapOptions("New Chat vsplit"))
        vim.keymap.set({ "n" }, "<leader>i<C-t>", "<cmd>GpChatNew tabnew<cr>", keymapOptions("New Chat tabnew"))

        vim.keymap.set("v", "<leader>i<C-x>", ":<C-u>'<,'>GpChatNew split<cr>", keymapOptions("Visual Chat New split"))
        vim.keymap.set(
            "v",
            "<leader>i<C-v>",
            ":<C-u>'<,'>GpChatNew vsplit<cr>",
            keymapOptions("Visual Chat New vsplit")
        )
        vim.keymap.set(
            "v",
            "<leader>i<C-t>",
            ":<C-u>'<,'>GpChatNew tabnew<cr>",
            keymapOptions("Visual Chat New tabnew")
        )

        -- Prompt commands
        vim.keymap.set({ "n" }, "<leader>ir", "<cmd>GpRewrite<cr>", keymapOptions("Inline Rewrite"))
        vim.keymap.set({ "n" }, "<leader>ia", "<cmd>GpAppend<cr>", keymapOptions("Append (after)"))
        vim.keymap.set({ "n" }, "<leader>ib", "<cmd>GpPrepend<cr>", keymapOptions("Prepend (before)"))

        vim.keymap.set("v", "<leader>ir", ":<C-u>'<,'>GpRewrite<cr>", keymapOptions("Visual Rewrite"))
        vim.keymap.set("v", "<leader>ia", ":<C-u>'<,'>GpAppend<cr>", keymapOptions("Visual Append (after)"))
        vim.keymap.set("v", "<leader>ib", ":<C-u>'<,'>GpPrepend<cr>", keymapOptions("Visual Prepend (before)"))
        vim.keymap.set("v", "<leader>ii", ":<C-u>'<,'>GpImplement<cr>", keymapOptions("Implement selection"))

        vim.keymap.set({ "n" }, "<leader>igp", "<cmd>GpPopup<cr>", keymapOptions("Popup"))
        vim.keymap.set({ "n" }, "<leader>ige", "<cmd>GpEnew<cr>", keymapOptions("GpEnew"))
        vim.keymap.set({ "n" }, "<leader>ign", "<cmd>GpNew<cr>", keymapOptions("GpNew"))
        vim.keymap.set({ "n" }, "<leader>igv", "<cmd>GpVnew<cr>", keymapOptions("GpVnew"))
        vim.keymap.set({ "n" }, "<leader>igt", "<cmd>GpTabnew<cr>", keymapOptions("GpTabnew"))

        vim.keymap.set("v", "<leader>igp", ":<C-u>'<,'>GpPopup<cr>", keymapOptions("Visual Popup"))
        vim.keymap.set("v", "<leader>ige", ":<C-u>'<,'>GpEnew<cr>", keymapOptions("Visual GpEnew"))
        vim.keymap.set("v", "<leader>ign", ":<C-u>'<,'>GpNew<cr>", keymapOptions("Visual GpNew"))
        vim.keymap.set("v", "<leader>igv", ":<C-u>'<,'>GpVnew<cr>", keymapOptions("Visual GpVnew"))
        vim.keymap.set("v", "<leader>igt", ":<C-u>'<,'>GpTabnew<cr>", keymapOptions("Visual GpTabnew"))

        vim.keymap.set({ "n" }, "<leader>ix", "<cmd>GpContext<cr>", keymapOptions("Toggle Context"))
        vim.keymap.set("v", "<leader>ix", ":<C-u>'<,'>GpContext<cr>", keymapOptions("Visual Toggle Context"))

        vim.keymap.set({ "n", "v", "x" }, "<leader>is", "<cmd>GpStop<cr>", keymapOptions("Stop"))
        vim.keymap.set({ "n", "v", "x" }, "<leader>in", "<cmd>GpNextAgent<cr>", keymapOptions("Next Agent"))

        -- optional Whisper commands with prefix <leader>iw
        vim.keymap.set({ "n" }, "<leader>iww", "<cmd>GpWhisper<cr>", keymapOptions("Whisper"))
        vim.keymap.set("v", "<leader>iww", ":<C-u>'<,'>GpWhisper<cr>", keymapOptions("Visual Whisper"))

        vim.keymap.set({ "n" }, "<leader>iwr", "<cmd>GpWhisperRewrite<cr>", keymapOptions("Whisper Inline Rewrite"))
        vim.keymap.set({ "n" }, "<leader>iwa", "<cmd>GpWhisperAppend<cr>", keymapOptions("Whisper Append (after)"))
        vim.keymap.set({ "n" }, "<leader>iwb", "<cmd>GpWhisperPrepend<cr>", keymapOptions("Whisper Prepend (before) "))

        vim.keymap.set("v", "<leader>iwr", ":<C-u>'<,'>GpWhisperRewrite<cr>", keymapOptions("Visual Whisper Rewrite"))
        vim.keymap.set(
            "v",
            "<leader>iwa",
            ":<C-u>'<,'>GpWhisperAppend<cr>",
            keymapOptions("Visual Whisper Append (after)")
        )
        vim.keymap.set(
            "v",
            "<leader>iwb",
            ":<C-u>'<,'>GpWhisperPrepend<cr>",
            keymapOptions("Visual Whisper Prepend (before)")
        )

        vim.keymap.set({ "n" }, "<leader>iwp", "<cmd>GpWhisperPopup<cr>", keymapOptions("Whisper Popup"))
        vim.keymap.set({ "n" }, "<leader>iwe", "<cmd>GpWhisperEnew<cr>", keymapOptions("Whisper Enew"))
        vim.keymap.set({ "n" }, "<leader>iwn", "<cmd>GpWhisperNew<cr>", keymapOptions("Whisper New"))
        vim.keymap.set({ "n" }, "<leader>iwv", "<cmd>GpWhisperVnew<cr>", keymapOptions("Whisper Vnew"))
        vim.keymap.set({ "n" }, "<leader>iwt", "<cmd>GpWhisperTabnew<cr>", keymapOptions("Whisper Tabnew"))

        vim.keymap.set("v", "<leader>iwp", ":<C-u>'<,'>GpWhisperPopup<cr>", keymapOptions("Visual Whisper Popup"))
        vim.keymap.set("v", "<leader>iwe", ":<C-u>'<,'>GpWhisperEnew<cr>", keymapOptions("Visual Whisper Enew"))
        vim.keymap.set("v", "<leader>iwn", ":<C-u>'<,'>GpWhisperNew<cr>", keymapOptions("Visual Whisper New"))
        vim.keymap.set("v", "<leader>iwv", ":<C-u>'<,'>GpWhisperVnew<cr>", keymapOptions("Visual Whisper Vnew"))
        vim.keymap.set("v", "<leader>iwt", ":<C-u>'<,'>GpWhisperTabnew<cr>", keymapOptions("Visual Whisper Tabnew"))

        require("which-key").add({
            -- VISUAL mode mappings
            -- s, x, v modes are handled the same way by which_key
            {
                mode = { "v" },
                nowait = true,
                remap = false,
                { "<leader>ig", group = "generate into new .." },
                { "<leader>iw", group = "Whisper" },
            },

            -- NORMAL mode mappings
            {
                mode = { "n" },
                nowait = true,
                remap = false,
                { "<leader>ig", group = "generate into new .." },
                { "<leader>iw", group = "Whisper" },
            },
        })
    end,
}

return M
