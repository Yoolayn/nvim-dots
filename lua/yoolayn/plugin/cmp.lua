return {
    {
        "hrsh7th/nvim-cmp",
        event = { "InsertEnter" },
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-cmdline",
        },
        config = function()
            require("yoolayn.config.cmp")
            local colors = require("yoolayn.config.cmp-colors")
            colors.run(false)
            colors.set_autocmd()
        end,
    },
}
