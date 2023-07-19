local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "scala", "sbt", "java" },
	callback = function()
		require("metals").initialize_or_attach({})
		local metals_config = require("metals").bare_config()
		metals_config.settings = {
			showImplicitArguments = true,
			serverVersion = "latest.snapshot",
		}
		metals_config.init_options.statusBarProvider = "on"
		metals_config.on_attach = function(client, bufnr)
			require("metals").setup_dap()
		end
	end,
	group = nvim_metals_group,
})

return {
	"scalameta/nvim-metals",
	dependencies = { "nvim-lua/plenary.nvim" },
	ft = "scala",
}
