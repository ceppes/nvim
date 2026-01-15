return {
    "letieu/jira.nvim",
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

            active_sprint_query = "project = '%s' AND sprint in openSprints() ORDER BY Rank ASC",

            -- Saved JQL queries for the JQL tab
            -- Use %s as a placeholder for the project key
            queries = {
                ["Next sprint"] = "project = '%s' AND sprint in futureSprints() ORDER BY Rank ASC",
                ["Backlog"] = "project = '%s' AND (issuetype IN standardIssueTypes() OR issuetype = Sub-task) AND (sprint IS EMPTY OR sprint NOT IN openSprints()) AND statusCategory != Done ORDER BY Rank ASC",
                ["My Tasks"] = "assignee = currentUser() AND statusCategory != Done ORDER BY updated DESC",
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
