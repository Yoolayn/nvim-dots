-- local Utils = require("yoolayn.utils")

vim.g.mapleader = " "
vim.g.localleader = "\\"

-- disable scroll full page
vim.keymap.set("n", "<C-b>", "<Nop>")
vim.keymap.set("n", "<C-f>", "<Nop>")

-- recenter screen
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "scroll down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "scroll up" })
vim.keymap.set("n", "n", "nzzzv", { desc = "next search" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "prev search" })

-- text objects
vim.keymap.set({ "o", "x" }, "il", ":<c-u>norm! _vg_<cr>", { desc = "inner line", silent = true })
vim.keymap.set({ "o", "x" }, "al", ":<c-u>norm! 0v$<cr>", { desc = "a line", silent = true })
vim.keymap.set({ "o", "x" }, "i_", ":<c-u>norm! T_vt_<cr>", { desc = "inner underscore", silent = true})
vim.keymap.set({ "o", "x" }, "a_", ":<c-u>norm! F_vf_<cr>", { desc = "a underscore", silent = true})

-- clipboard interaction
vim.keymap.set( { "n", "v" }, "<leader>y", [["+y]], { desc = "yank to clipboard" })
vim.keymap.set("n", "<leader>Y", [["+yy]], { desc = "Yank to clipboard" })
vim.keymap.set("n", "<leader>p", [["+p]], { desc = "paste from clipboard" })
vim.keymap.set("n", "<leader>P", [["+P]], { desc = "Paste from clipboard" })

-- blackhole register
vim.keymap.set( { "n", "v" }, "<leader>d", [["_d]], { desc = "delete to black hole" })

-- misc
vim.keymap.set("n", "J", "mzJ`z", { desc = "join lines" })
vim.keymap.set("n", "gp", "`[v`]", { desc = "select pasted test" })
vim.keymap.set("n", "Y", "yy", { desc = "copy line" })
vim.keymap.set("n", "U", "<c-r>", { desc = "redo" })

-- substitute commands
vim.keymap.set(
    "n",
    "<leader>s",
    [[:s/<C-r><C-w>/<C-r><C-w>/g<Left><Left>]],
    { desc = "replace inline instances under cursor" }
)
vim.keymap.set(
    "n",
    "<leader>S",
    [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gc<Left><Left><Left>]],
    { desc = "replace all instances under cursor" }
)
vim.keymap.set(
    "v",
    "<leader>s",
    [[y:s/<c-r>"/<c-r>"/g<left><left>]],
    { desc = "replace marked inline" }
)
vim.keymap.set(
    "v",
    "<leader>S",
    [[y:%s/<c-r>"//gc<left><left><left>]],
    { desc = "replace all marked" }
)