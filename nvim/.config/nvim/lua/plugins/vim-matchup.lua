return {
    "andymass/vim-matchup",
    config = function ()
        vim.g.matchup_matchparen_enabled = 1
        vim.g.matchup_matchparen_deferred = 1
        vim.g.matchup_matchparen_hi_surround_always = 1
    end
}
