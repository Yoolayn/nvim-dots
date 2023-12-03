local options = {}

options.options = {
	rnu = true,
	nu = true,
	spell = true,
	spl = "en_us,en_gb,pl",
	tabstop = 4,
	shiftwidth = 4,
	smartindent = true,
	expandtab = false,
	exrc = true,
	list = true,
	listchars = {
		append = {
			[[trail:-]],
			[[tab:\u0020\u0020]],
			[[precedes:\u2190]],
			[[extends:\u2192]],
			[[leadmultispace:\u00b7]],
			[[nbsp:\u2423]]
		},
	},
	linebreak = true,
	showbreak = "-> ",
	path = ".,**",
	ignorecase = true,
	smartcase = true,
	incsearch = true,
	foldlevel = (function()
		if vim.fn.has("nvim-0.10") == 1 then
			return 20
		else
			return 0
		end
	end)(),
	foldexpr = (function()
		if vim.fn.has("nvim-0.10") == 1 then
			return "v:lua.vim.treesitter.foldexpr()"
		else
			return "0"
		end
	end)(),
	foldtext = (function()
		if vim.fn.has("nvim-0.10") == 1 then
			return "v:lua.vim.treesitter.foldtext()"
		else
			return "foldtext()"
		end
	end)(),
	foldmethod = (function()
		if vim.fn.has("nvim-0.10") == 1 then
			return "expr"
		else
			return "manual"
		end
	end)(),
	hls = true,
	cursorline = true,
	guicursor = "i-ci-ve:block",
	showtabline = 0,
	scrolloff = 8,
	termguicolors = true,
	signcolumn = "yes",
	inccommand = "split",
	splitright = true,
	splitbelow = true,
	timeoutlen = 10000,
	updatetime = 50,
	swapfile = true,
	dir = os.getenv("HOME") .. "/.local/state/nvim/swap",
	writebackup = false,
	shortmess = {
		append = "c",
	},
	showmode = false,
	laststatus = 3,
	undofile = true,
	undodir = os.getenv("HOME") .. "/.config/nvim/undo",
	wildmode = "longest:full,full",
	completeopt = "menu,noselect",
	winminwidth = 5,
	pumheight = 6,
	wrap = true,
}

options.prg = {
	grep = "rg --vimgrep --no-heading --smart-case",
}

options.globals = {
	markdown_recommended_style = 0,
}

local function set_option(name, opts)
	local obj = vim.opt[name]
	for func, value in pairs(opts) do
		if type(value) ~= "table" then
			obj[func](obj, value)
		else
			for _, atom in ipairs(value) do
				obj[func](obj, atom)
			end
		end
	end
end

for key, value in pairs(options.prg) do
	key = key .. "prg"
	vim.opt[key] = value
end

for key, value in pairs(options.globals) do
	vim.g[key] = value
end

for key, value in pairs(options.options) do
	if type(value) ~= "table" then
		vim.opt[key] = value
	else
		set_option(key, value)
	end
end
