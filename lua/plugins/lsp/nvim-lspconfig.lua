return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{ "folke/neoconf.nvim", cmd = "Neoconf", config = true },
		{ "folke/neodev.nvim", opts = {} },
		"mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		{
			"hrsh7th/cmp-nvim-lsp",
			cond = function()
				return require("yoolayn.util.funcs").has("nvim-cmp")
			end,
		},
	},
	---@class PluginLspOpts
	opts = {
		diagnostics = {
			underline = true,
			update_in_insert = false,
			virtual_text = {
				spacing = 4,
				source = "if_many",
				prefix = "●",
			},
			severity_sort = true,
		},
		inlay_hints = {
			enabled = false, -- configure the server itself to work properly, along with this setting
		},
		capabilities = {}, -- global capabilities (work on any server)
		autoformat = true,
		format_notify = false, -- Notify which formater does the formatting
		format = {
			formatting_options = nil,
			timeout_ms = nil,
		},
		-- LSP Server Settings
		---@diagnostic disable-next-line
		---@type lspconfig.options
		servers = {
			jsonls = {},
			lua_ls = {
				---@diagnostic disable-next-line
				---@type LazyKeys[]
				-- keys = {},
				settings = {
					Lua = {
						workspace = {
							checkThirdParty = false,
						},
						completion = {
							callSnippet = "Replace",
						},
					},
				},
			},
		},
	},
	---@param opts PluginLspOpts
	config = function(_, opts)
		local Util = require("yoolayn.util.funcs")
		-- setup autoformat
		require("yoolayn.util.lsp.format").setup(opts)
		-- setup formatting and keymaps
		Util.on_attach(function(client, buffer)
			require("yoolayn.util.lsp.keymaps").on_attach(client, buffer)
		end)

		local register_capability = vim.lsp.handlers["client/registerCapability"]

		---@diagnostic disable-next-line
		vim.lsp.handlers["client/registerCapability"] = function(err, res, ctx)
			local ret = register_capability(err, res, ctx)
			local client_id = ctx.client_id
			---@type lsp.Client
			local client = vim.lsp.get_client_by_id(client_id)
			local buffer = vim.api.nvim_get_current_buf()
			require("yoolayn.util.lsp.keymaps").on_attach(client, buffer)
			return ret
		end

		-- diagnostics
		for name, icon in pairs(require("yoolayn.data.icons").diagnostics) do
			name = "DiagnosticSign" .. name
			vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
		end

		local inlay_hint = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint

		if opts.inlay_hints.enabled and inlay_hint then
			Util.on_attach(function(client, buffer)
				if client.server_capabilities.inlayHintProvider then
					inlay_hint(buffer, true)
				end
			end)
		end

		if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
			opts.diagnostics.virtual_text.prefix = vim.fn.has("nvim-0.10.0") == 0 and "●"
				or function(diagnostic)
					local icons = require("yoolayn.data.icons").diagnostics
					for d, icon in pairs(icons) do
						if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
							return icon
						end
					end
				end
		end

		vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

		local servers = opts.servers
		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			require("cmp_nvim_lsp").default_capabilities(),
			opts.capabilities or {}
		)

		local function setup(server)
			local server_opts = vim.tbl_deep_extend("force", {
				capabilities = vim.deepcopy(capabilities),
			}, servers[server] or {})

			if opts.setup[server] then
				if opts.setup[server](server, server_opts) then
					return
				end
			elseif opts.setup["*"] then
				if opts.setup["*"](server, server_opts) then
					return
				end
			end
			require("lspconfig")[server].setup(server_opts)
		end

		-- get all the servers that are available thourgh mason-lspconfig
		local have_mason, mlsp = pcall(require, "mason-lspconfig")
		local all_mslp_servers = {}
		if have_mason then
			all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
		end

		local ensure_installed = {} ---@type string[]
		for server, server_opts in pairs(servers) do
			if server_opts then
				server_opts = server_opts == true and {} or server_opts
				-- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
				if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
					setup(server)
				else
					ensure_installed[#ensure_installed + 1] = server
				end
			end
		end

		if have_mason then
			mlsp.setup({ ensure_installed = ensure_installed, handlers = { setup } })
		end

		if Util.lsp_get_config("denols") and Util.lsp_get_config("tsserver") then
			local is_deno = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc")
			Util.lsp_disable("tsserver", is_deno)
			Util.lsp_disable("denols", function(root_dir)
				return not is_deno(root_dir)
			end)
		end
	end,
}