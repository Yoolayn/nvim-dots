vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniFilesWindowUpdate',
  callback = function(args) vim.wo[args.data.win_id].relativenumber = true end,
})

return {
    "echasnovski/mini.files",
    config = function()
        require("mini.files").setup()
    end,
    keys = {
        {
            "<leader>E",
            function()
                MiniFiles.open(vim.api.nvim_buf_get_name(0), false),
            end,
            desc = "MiniFiles",
        },
    },
}