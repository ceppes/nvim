return {
    "letieu/jira.nvim",
    cmd = "Jira",
    keys = {
        { "<leader>jj", function() vim.cmd("Jira " .. (vim.env.JIRA_PROJECT or "")) end, desc = "Open Jira Board" },
    },
    config = function()
        require("jira").setup({
            -- Jira connection settings
            jira = {
                base = "https://your-domain.atlassian.net", -- Base URL of your Jira instance
                email = "your-email@example.com", -- Your Jira email (Optional for PAT)
                token = "your-api-token", -- Your Jira API token or PAT
                type = "basic", -- Authentication type: "basic" (default) or "pat"
                limit = 200, -- Global limit of tasks per view (default: 200)
            },

            -- Kanban board query: In Progress first, then To Do, grouped by assignee, sorted by updated
            active_sprint_query = "project = '%s' AND statusCategory != Done ORDER BY statusCategory DESC, assignee ASC, updated DESC",

            -- Saved JQL queries for Kanban workflow
            -- Use %s as a placeholder for the project key
            queries = {
                ["All Issues"] = "project = '%s' ORDER BY statusCategory DESC, assignee ASC, updated DESC",
                ["To Do"] = "project = '%s' AND statusCategory = 'To Do' ORDER BY created DESC",
                ["In Progress"] = "project = '%s' AND statusCategory = 'In Progress' ORDER BY created DESC",
                ["Done"] = "project = '%s' AND statusCategory = 'Done' ORDER BY updated DESC",
                ["My Tasks"] = "project = '%s' AND assignee = currentUser() ORDER BY updated DESC",
            },

            -- Project-specific overrides
            projects = {
                ["DEV"] = {
                    story_point_field = "customfield_10035", -- Custom field ID for story points
                    custom_fields = { -- Custom field to display in markdown view
                        { key = "customfield_10016", label = "Acceptance Criteria" },
                    },
                },
            },
        })
    end,
}
