require("mini.deps").add("rebelot/kanagawa.nvim")

require("mini.deps").now(function()
    require("kanagawa").setup({
        transparent = false,
        colors = {
            theme = {
                all = { ui = { bg_gutter = "none" } },
            },
        },
        overrides = function(colors)
            local theme = colors.theme
            return {
                Normal = { bg = "#16161d" },
                Whitespace = {
                    bg = "none",
                    fg = "#1e1e28"
                },
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
                Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
                PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
                PmenuSbar = { bg = theme.ui.bg_m1 },
                PmenuThumb = { bg = theme.ui.bg_p2 },
                -- ["@string.regexp"] = { link = "@string.regex" },
                -- ["@variable.parameter"] = { link = "@parameter" },
                -- ["@exception"] = { link = "@exception" },
                -- ["@string.special.symbol"] = { link = "@symbol" },
                -- ["@markup.strong"] = { link = "@text.strong" },
                -- ["@markup.italic"] = { link = "@text.emphasis" },
                -- ["@markup.heading"] = { link = "@text.title" },
                -- ["@markup.raw"] = { link = "@text.literal" },
                -- ["@markup.quote"] = { link = "@text.quote" },
                -- ["@markup.math"] = { link = "@text.math" },
                -- ["@markup.environment"] = { link = "@text.environment" },
                -- ["@markup.environment.name"] = { link = "@text.environment.name" },
                -- ["@markup.link.url"] = { link = "Special" },
                -- ["@markup.link.label"] = { link = "Identifier" },
                -- ["@comment.note"] = { link = "@text.note" },
                -- ["@comment.warning"] = { link = "@text.warning" },
                -- ["@comment.danger"] = { link = "@text.danger" },
                -- ["@diff.plus"] = { link = "@text.diff.add" },
                -- ["@diff.minus"] = { link = "@text.diff.delete" },
                -- ["@keyword.import.go"] = { link = "@keyword.return" },
                -- ["@module.go"] = { link = "Identifier" },
                -- ["@property.go"] = { link = "Identifier" },
                -- ["@field.go"] = { link = "Identifier" },
                -- ["@namespace.go"] = { link = "Identifier" },
                -- ["@variable.member.go"] = { link = "Identifier" },
            }
        end,
    })
    vim.cmd.colorscheme "kanagawa"
end)

-- {
--     "dasupradyumna/midnight.nvim",
--     -- opts = {},
--     config = function(_, opts)
--         require("midnight").setup(opts)
--         vim.cmd.colorscheme "midnight"
--     end
-- },
