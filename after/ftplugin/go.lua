vim.opt_local.expandtab = false
vim.opt_local.shiftwidth = 8
vim.opt_local.tabstop = 8
vim.api.nvim_create_autocmd("BufEnter", {
    once = true,
    callback = function()
        vim.opt.indentkeys:remove("<:>")
        vim.opt_local.formatoptions:append("ro")
    end
})

local ok, go = pcall(require, "gopher")
if ok then
    go.setup({
        go = "go",
        gomodifytags = "gomodifytags",
        gotests = "gotests",
        impl = "impl",
        iferr = "iferr",
    })

    require("gopher.dap").setup()
end

