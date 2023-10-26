return {
	"scalameta/nvim-metals",
	event = {"BufEnter", "BufReadPre"},
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function(_, _)
		local metals = require("metals")
		local metals_config = metals.bare_config()
		metals_config.settings = {
			showImplicitArguments = true,
		}
		metals_config.init_options.statusBarProvider = "on"
		metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()
		local dap = require("dap")
		dap.configurations.scala = {
			{
				type = "scala",
				request = "launch",
				name = "Run with arg and env file",
				metals = {},
			}
		}

		metals_config.on_attach = function(client, bufnr)
			metals.setup_dap()
		end

		vim.keymap.set("n", "<leader>lmc", function()
			require("telescope").extensions.metals.commands()
		end)

		local nvim_metals_group = vim.api.nvim_create_augroup("metals", { clear = true })
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "scala", "sbt", "java" },
			callback = function()
				metals.initialize_or_attach(metals_config)
			end,
			group = nvim_metals_group,
		})
	end,
}