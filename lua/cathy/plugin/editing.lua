local add   = require("mini.deps").add
local later = require("mini.deps").later

add("kylechui/nvim-surround")

later(function()
    ---@diagnostic disable-next-line
    require("nvim-surround").setup({
        keymaps = {
            insert = "<c-d>",
            insert_line = "<c-s>",
            normal = "s",
            normal_cur = "ss",
            normal_line = "S",
            normal_cur_line = "SS",
            visual = "s",
            visual_line = "S",
            delete = "ds",
            change = "cs",
            change_line = "cS",
        }
    })
end)

add({
    source = "windwp/nvim-autopairs",
    depends = { "hrsh7th/nvim-cmp", }
})
later(function()
    require("nvim-autopairs").setup()
    require("nvim-autopairs").remove_rule('"')
    require("nvim-autopairs").remove_rule("'")
    require("nvim-autopairs").remove_rule('`')
    require("nvim-autopairs").remove_rule('(')
    require("nvim-autopairs").remove_rule('[')
    require("nvim-autopairs").remove_rule('{')
    local ok, _ = pcall(require, "cmp")
    if ok then
        require("cathy.config.cmp-pairs")
    end
    require("cathy.config.pair-customrules")
end)

add("monaqa/dial.nvim")
later(function()
    local augend = require("dial.augend")
    require("dial.config").augends:register_group({
        default = {
            augend.integer.alias.binary,
            augend.integer.alias.decimal,
            augend.integer.alias.hex,
            augend.constant.alias.bool,
            augend.case.new{
                types = {
                    "camelCase",
                    "PascalCase",
                    "snake_case",
                    "SCREAMING_SNAKE_CASE",
                },
                cyclic = true,
            },
            augend.date.alias["%d/%m/%Y"],
            augend.constant.new({ elements = { "&&", "||" }, word = false, cyclic = true }),
            augend.constant.new({ elements = { "and", "or" } }),
        }
    })
	require("dial.config").augends:on_filetype({
        python = {
            augend.constant.new({ elements = { "True", "False" } }),
        }
    })

    vim.keymap.set("n", "<C-a>",  function() require("dial.map").manipulate("increment", "normal") end)
    vim.keymap.set("n", "<C-x>",  function() require("dial.map").manipulate("decrement", "normal") end)
    vim.keymap.set("n", "g<C-a>", function() require("dial.map").manipulate("increment", "gnormal") end)
    vim.keymap.set("n", "g<C-x>", function() require("dial.map").manipulate("decrement", "gnormal") end)
    vim.keymap.set("v", "<C-a>",  function() require("dial.map").manipulate("increment", "visual") end)
    vim.keymap.set("v", "<C-x>",  function() require("dial.map").manipulate("decrement", "visual") end)
    vim.keymap.set("v", "g<C-a>", function() require("dial.map").manipulate("increment", "gvisual") end)
    vim.keymap.set("v", "g<C-x>", function() require("dial.map").manipulate("decrement", "gvisual") end)
end)
