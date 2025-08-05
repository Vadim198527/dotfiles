return {
    "NeogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim", -- required
        "sindrets/diffview.nvim", -- optional - Diff integration

        -- Only one of these is needed.
        "nvim-telescope/telescope.nvim", -- optional
    },
    config = function()
        require("neogit").setup({
            -- Core behavior
            disable_hint = false,        -- Show hints at top of status buffer
            disable_context_highlighting = false, -- Highlight based on cursor position
            disable_signs = false,       -- Show signs for sections/items/hunks
            prompt_force_push = true,    -- Ask before force-pushing divergent branches
            disable_insert_on_commit = "auto", -- "auto": Insert mode if commit message empty, else normal
            auto_refresh = true,         -- Auto-refresh after Git events
            sort_branches = "-committerdate", -- Sort branches by recent commits
            initial_branch_name = "",    -- Default name prompt for new branches
            kind = "floating",           -- Open as floating window (modern feel; alternatives: "tab", "split", "replace")
            use_per_project_settings = true, -- Persist settings per repo
            remember_settings = true,    -- Save toggles/options across sessions
            ignored_settings = {},       -- Settings to never persist (e.g., {"Status--show-untracked-files"})

            -- File watching for auto-updates
            filewatcher = {
                interval = 1000, -- Check .git/ every 1 second (ms)
                enabled = true,
            },

            -- UI customizations
            graph_style = "unicode", -- Nicer commit graph ("ascii" or "kitty" alternatives)
            process_spinner = false, -- Hide spinning animation during Git commands
            highlight = {
                italic = true,
                bold = true,
                underline = true,
            },
            floating = {
                relative = "editor", -- Position relative to editor
                width = 0.8, -- 80% of editor width
                height = 0.7, -- 70% of editor height
                border = "rounded", -- Border style (options: "single", "double", etc.)
            },

            -- Commit editor settings
            commit_editor = {
                kind = "auto",        -- Window type ("tab", "split", etc.)
                show_staged_diff = true, -- Show staged changes diff in commit view
                staged_diff_split_kind = "split", -- How to split the staged diff ("vsplit", "auto")
                spell_check = true,   -- Enable spell-checking in commit message
            },

            -- Status view customizations
            status = {
                show_head_commit_hash = true, -- Display HEAD commit hash
                recent_commit_count = 10, -- Show last 10 commits in recent section
                HEAD_folded = false, -- Expand HEAD section by default
                -- Mode text icons (customize for clarity)
                mode_padding = 3,
                mode_text = {
                    M = "modified",
                    N = "new file",
                    A = "added",
                    D = "deleted",
                    C = "copied",
                    U = "updated",
                    R = "renamed",
                    DD = "unmerged",
                    AU = "unmerged",
                    UD = "unmerged",
                    UA = "unmerged",
                    DU = "unmerged",
                    AA = "unmerged",
                    UU = "unmerged",
                    ["?"] = "",
                },
            },

            -- Integrations (enable what you have installed)
            integrations = {
                telescope = nil, -- Set to true if telescope.nvim is installed for fuzzy menus
                diffview = true, -- Enable for VSCode-like diff panels (requires diffview.nvim)
                fzf_lua = nil, -- Alternative fuzzy finder
                mini_pick = nil, -- Another finder option
            },

            -- Keymaps (use defaults, but you can override)
            use_default_keymaps = true, -- Enable built-in mappings (disable to customize fully)
            mappings = {
                -- Customize if needed; defaults are intuitive (e.g., 's' to stage, 'c' to commit)
                -- Example override: finder = { ["<cr>"] = "Select" },
            },

            -- Other advanced options (defaults are fine for most)
            telescope_sorter = function()
                return nil
            end,    -- Custom sorter if using telescope
            git_services = { -- Templates for PRs on GitHub, etc. (defaults work)
                ["github.com"] = "https://github.com/${owner}/${repository}/compare/${branch_name}?expand=1",
                -- Add more for GitLab, Bitbucket, etc.
            },
        })
    end,
}
