return {
    "rebelot/kanagawa.nvim",
    config = function()
        require("kanagawa").setup({
            transparent = true,
            colors = {
                theme = {
                    all = { ui = { bg_gutter = "none" } },
                },
            },
            overrides = function(colors)
                local theme = colors.theme
                return {
                    TelescopeTitle = {
                        fg = theme.ui.special,
                        bg = theme.ui.bg_p1,
                        bold = true,
                    },
                    TelescopePromptBorder = {
                        fg = theme.ui.bg_p1,
                        bg = "NONE",
                    },
                    TelescopeResultsNormal = {
                        fg = theme.ui.fg_dim,
                        bg = "NONE",
                    },
                    TelescopeResultsBorder = {
                        fg = theme.ui.bg_m1,
                        bg = "NONE",
                    },
                    TelescopePreviewBorder = {
                        fg = theme.ui.bg_dim,
                        bg = "NONE",
                    },
                    Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },  -- add `blend = vim.o.pumblend` to enable transparency
                    PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
                    PmenuSbar = { bg = theme.ui.bg_m1 },
                    PmenuThumb = { bg = theme.ui.bg_p2 },
                }
            end,
        })
    end
}
