------------------- options -------------------

vim.o.number = true
vim.o.mouse = "a"
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.sidescrolloff = 8
vim.o.autowrite = true
vim.o.undofile = true
vim.o.confirm = true
vim.o.laststatus = 3
vim.o.smoothscroll = true
vim.o.linebreak = true
vim.o.termguicolors = true
vim.o.wrap = false
vim.o.list = true
vim.opt.listchars = { tab = "  ", trail = "·", nbsp = "␣" }
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.completeopt = "menu,menuone,noselect"
vim.o.softtabstop = 2
vim.o.winborder = "rounded"
vim.o.pumborder = "rounded"
vim.o.swapfile = false

-- hide the mode
vim.o.showmode = false

-- enables clipboard syncing between nvim and system
vim.schedule(function()
	vim.o.clipboard = vim.env.SSH_CONNECTION and "" or "unnamedplus"
end)

-- some formatting shit
vim.o.breakindent = true
vim.o.smartindent = true
vim.o.signcolumn = "yes"
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.softtabstop = 2

-- case insensitive searching enless there are a capital letters
vim.o.ignorecase = true
vim.o.smartcase = true

-- position for new splits
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.splitkeep = "screen"

-- highlight when yanking text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "highlight when yanking text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	group = vim.api.nvim_create_augroup("checktime", { clear = true }),
	callback = function()
		if vim.o.buftype ~= "nofile" then
			vim.cmd("checktime")
		end
	end,
})

-- Restore last cursor position
vim.api.nvim_create_autocmd("BufWinEnter", {
	callback = function(ev)
		local lastpos = vim.api.nvim_buf_get_mark(ev.buf, '"')
		if vim.wo.diff or ({
			gitcommit = true,
			gitrebase = true,
			xxd = true,
		})[vim.bo[ev.buf].filetype] then
			return
		end
		if pcall(vim.api.nvim_win_set_cursor, 0, lastpos) then
			vim.cmd("normal! zz")
		end
	end,
})

-- creates dir if not exits
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	group = vim.api.nvim_create_augroup("auto_create_dir", { clear = true }),
	callback = function(event)
		if event.match:match("^%w%w+:[\\/][\\/]") then
			return
		end
		local file = vim.uv.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})

------------------- colors -------------------

local palette = {
	bg = "#FFFFFF",
	bg_alt = "#F2F2F2",
	bg_dark = "#E6E6E6",
	bg_light = "#F9F9F9",
	bg_highlight = "#ECF5FF",
	fg = "#000000",
	fg_alt = "#262626",
	fg_dark = "#4D4D4D",
	fg_darker = "#707F8C",
	keyword = "#9B2393",
	string = "#C41A16",
	comment = "#5D6C79",
	number = "#1C00CF",
	boolean = "#9B2393",
	function_name = "#164E54",
	variable = "#26474B",
	constant = "#02638C",
	type = "#3900A0",
	property = "#0B5561",
	parameter = "#000000",
	purple = "#9B2393",
	preprocessor = "#643820",
	attribute = "#815F03", --
	operator = "#000000",
	punctuation = "#000000",
	cursor = "#000000",
	cursor_visual = "#B2D7FF",
	cursor_line = "#ECF5FF",
	selection = "#B2D7FF",
	visual = "#B2D7FF",
	search = "#fefcbf",
	search_fg = "#000000",
	line_number = "#A6A6A6",
	gutter_bg = "#FFFFFF",
	border = "#D1D1D1",
	separator = "#E6E6E6",
	status_bg = "#F2F2F2",
	status_fg = "#4D4D4D",
	error = "#D12F1B",
	warning = "#815F03",
	info = "#02638C",
	hint = "#3900a0",
	pmenu_bg = "#F2F2F2",
	pmenu_fg = "#000000",
	pmenu_sel_bg = "#B2D7FF",
	pmenu_sel_fg = "#000000",
	git_add = "#1A7F37",
	git_change = "#9A6700",
	git_delete = "#D12F1B",
	git_ignored = "#707F8C",
}

local c = palette
vim.o.background = "light"
vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
	vim.cmd("syntax reset")
end
vim.g.colors_name = "xcodelight"

local groups = {
	-- Base Editor
	Normal = { fg = c.fg, bg = c.bg },
	NormalFloat = { fg = c.fg, bg = c.bg_light },
	Cursor = { fg = c.bg, bg = c.cursor },
	CursorLine = { bg = c.cursor_line },
	LineNr = { fg = c.line_number, bg = c.gutter_bg },
	SignColumn = { bg = c.gutter_bg },
	Visual = { bg = c.visual },
	Search = { fg = c.search_fg, bg = c.search },
	DiffAdd = { fg = c.git_add, bg = c.bg_highlight },
	DiffChange = { fg = c.git_change, bg = c.bg_highlight },
	DiffDelete = { fg = c.git_delete, bg = c.bg_highlight },
	DiffText = { fg = c.fg, bg = c.selection, bold = true },
	WinSeparator = { fg = c.separator },
	StatusLine = { fg = c.status_fg, bg = c.status_bg },
	Pmenu = { fg = c.pmenu_fg, bg = c.pmenu_bg },
	PmenuSel = { fg = c.pmenu_sel_fg, bg = c.pmenu_sel_bg },
	FloatBorder = { fg = c.border, bg = c.bg_light },
	Directory = { fg = c.type, bold = true },

	-- Syntax
	Comment = { fg = c.comment, italic = true },
	Constant = { fg = c.constant },
	String = { fg = c.string },
	Number = { fg = c.number },
	Boolean = { fg = c.boolean, bold = true },
	Function = { fg = c.function_name },
	Statement = { fg = c.keyword, bold = true },
	Keyword = { fg = c.keyword, bold = true },
	Type = { fg = c.type },
	PreProc = { fg = c.preprocessor, bold = true },
	Identifier = { fg = c.variable },
	Operator = { fg = c.operator },
	Delimiter = { fg = c.punctuation },

	-- TreeSitter
	["@variable"] = { fg = c.variable },
	["@variable.builtin"] = { fg = c.keyword, bold = true },
	["@variable.parameter"] = { fg = c.parameter },
	["@variable.member"] = { fg = c.property },
	["@property"] = { fg = c.property },
	["@function"] = { fg = c.function_name },
	["@function.call"] = { fg = c.function_name },
	["@function.builtin"] = { fg = c.type },
	["@keyword"] = { fg = c.keyword, bold = true },
	["@keyword.function"] = { fg = c.keyword, bold = true },
	["@keyword.return"] = { fg = c.keyword, bold = true },
	["@tag"] = { fg = c.keyword, bold = true },
	["@tag.attribute"] = { fg = c.attribute },
	["@type.builtin"] = { fg = c.type },
	["@operator"] = { fg = c.operator },
	["@punctuation"] = { fg = c.punctuation },

	-- LSP
	["@lsp.type.class"] = { fg = c.type },
	["@lsp.type.function"] = { fg = c.function_name },
	["@lsp.type.method"] = { fg = c.function_name },
	["@lsp.type.property"] = { fg = c.property },
	["@lsp.type.variable"] = { fg = c.variable },
	["@lsp.type.parameter"] = { fg = c.parameter },
	DiagnosticError = { fg = c.error },
	DiagnosticWarn = { fg = c.warning },
	DiagnosticInfo = { fg = c.info },
	DiagnosticHint = { fg = c.hint },

	-- Telescope
	TelescopeNormal = { fg = c.fg, bg = c.bg_light },
	TelescopeBorder = { fg = c.border, bg = c.bg_light },
	TelescopeSelection = { fg = c.fg, bg = c.selection, bold = true },
	TelescopeMatching = { fg = c.number, bold = true },

	-- Gitsigns
	GitSignsAdd = { fg = c.git_add, bg = c.gutter_bg },
	GitSignsChange = { fg = c.git_change, bg = c.gutter_bg },
	GitSignsDelete = { fg = c.git_delete, bg = c.gutter_bg },

	-- mini.statusline
	MiniStatuslineModeNormal = { fg = c.bg, bg = c.constant, bold = true },
	MiniStatuslineModeInsert = { fg = c.bg, bg = c.git_add, bold = true },
	MiniStatuslineModeVisual = { fg = c.bg, bg = c.keyword, bold = true },
	MiniStatuslineModeReplace = { fg = c.bg, bg = c.error, bold = true },
	MiniStatuslineModeCommand = { fg = c.bg, bg = c.type, bold = true },
	MiniStatuslineDevinfo = { fg = c.status_fg, bg = c.bg_alt },
	MiniStatuslineFilename = { fg = c.status_fg, bg = c.bg_dark, bold = true },
	MiniStatuslineFileinfo = { fg = c.status_fg, bg = c.bg_alt },
	MiniStatuslineInactive = { fg = c.fg_darker, bg = c.bg_alt },

	-- mini.tabline
	MiniTablineCurrent = { fg = c.fg, bg = c.bg_dark, bold = true },
	MiniTablineVisible = { fg = c.fg, bg = c.bg_alt },
	MiniTablineHidden = { fg = c.fg_darker, bg = c.bg_alt },
	MiniTablineModifiedCurrent = { fg = c.git_change, bg = c.bg_dark, bold = true },
	MiniTablineModifiedVisible = { fg = c.git_change, bg = c.bg_alt },
	MiniTablineModifiedHidden = { fg = c.git_change, bg = c.bg_alt },
	MiniTablineFill = { bg = c.bg_alt },

	-- mini.icons (Integrated with Xcode palette)
	MiniIconsAzure = { fg = c.constant },
	MiniIconsBlue = { fg = c.number },
	MiniIconsCyan = { fg = c.function_name },
	MiniIconsGreen = { fg = c.git_add },
	MiniIconsGrey = { fg = c.comment },
	MiniIconsOrange = { fg = c.warning },
	MiniIconsPurple = { fg = c.keyword },
	MiniIconsRed = { fg = c.string },
	MiniIconsYellow = { fg = c.git_change },

	-- mini.hipatterns
	MiniHipatternsFixme = { fg = c.bg, bg = c.error, bold = true },
	MiniHipatternsHack = { fg = c.bg, bg = c.warning, bold = true },
	MiniHipatternsTodo = { fg = c.bg, bg = c.info, bold = true },
	MiniHipatternsNote = { fg = c.bg, bg = c.hint, bold = true },

	-- WhichKey
	WhichKey = { fg = c.keyword, bold = true },
	WhichKeyGroup = { fg = c.type },
	WhichKeyDesc = { fg = c.fg },
	WhichKeySeparator = { fg = c.fg_darker },

	-- Tiny Code Action
	TinyCodeActionNormal = { fg = c.fg, bg = c.bg_light },
	TinyCodeActionBorder = { fg = c.border, bg = c.bg_light },

	-- render-markdown
	RenderMarkdownH1 = { fg = c.purple, bg = c.bg_highlight, bold = true },
	RenderMarkdownH2 = { fg = c.info, bg = c.bg_highlight, bold = true },
	RenderMarkdownH3 = { fg = c.git_add, bg = c.bg_highlight, bold = true },
	RenderMarkdownH4 = { fg = c.git_change, bg = c.bg_highlight, bold = true },
	RenderMarkdownH5 = { fg = c.string, bg = c.bg_highlight, bold = true },
	RenderMarkdownH6 = { fg = c.attribute, bg = c.bg_highlight, bold = true },
	RenderMarkdownH1Bg = { bg = c.bg_highlight },
	RenderMarkdownH2Bg = { bg = c.bg_highlight },
	RenderMarkdownH3Bg = { bg = c.bg_highlight },
	RenderMarkdownH4Bg = { bg = c.bg_highlight },
	RenderMarkdownH5Bg = { bg = c.bg_highlight },
	RenderMarkdownH6Bg = { bg = c.bg_highlight },
	RenderMarkdownCode = { bg = c.bg_alt },
	RenderMarkdownCodeInline = { bg = c.bg_alt },
	RenderMarkdownBullet = { fg = c.purple, bold = true },
	RenderMarkdownQuote = { fg = c.comment, italic = true },
	RenderMarkdownDash = { fg = c.separator, bold = true },
	RenderMarkdownLink = { fg = c.info, underline = true, bold = true },
	RenderMarkdownWikiLink = { fg = c.info, underline = true, bold = true },
	RenderMarkdownTodoChecked = { fg = c.git_add, bold = true },
	RenderMarkdownTodoUnchecked = { fg = c.git_delete, bold = true },
	RenderMarkdownTableHead = { fg = c.purple, bg = c.bg_alt, bold = true },
	RenderMarkdownTableRow = { fg = c.fg },
	RenderMarkdownSuccess = { fg = c.git_add, bold = true },
	RenderMarkdownInfo = { fg = c.info, bold = true },
	RenderMarkdownWarn = { fg = c.warning, bold = true },
	RenderMarkdownError = { fg = c.error, bold = true },
	RenderMarkdownHint = { fg = c.hint, bold = true },
}

for group, opts in pairs(groups) do
	vim.api.nvim_set_hl(0, group, opts)
end

------------------- mappings -------------------

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- exit insert mode
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("i", "kj", "<Esc>")

vim.keymap.set("t", "jk", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("t", "kj", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- speed up movement
vim.keymap.set("n", "J", "15j")
vim.keymap.set("n", "K", "15k")
vim.keymap.set("v", "J", "15j")
vim.keymap.set("v", "K", "15k")
vim.keymap.set("n", "H", "15h")
vim.keymap.set("n", "L", "15l")
vim.keymap.set("v", "H", "15h")
vim.keymap.set("v", "L", "15l")

-- clear highlights on search in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<cr>")
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- better splits navigation
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- buffer navigation
vim.keymap.set("n", "{", "<cmd>bprev<cr>", { desc = "Previous buffer" })
vim.keymap.set("n", "}", "<cmd>bnext<cr>", { desc = "Next buffer" })

-- TODO WINDOW MOVING
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- autocompletion mappings
vim.keymap.set("i", "<C-j>", function()
	return vim.fn.pumvisible() == 1 and "<C-n>" or "<Tab>"
end, { expr = true, silent = true, desc = "Next completion item" })

vim.keymap.set("i", "<C-k>", function()
	return vim.fn.pumvisible() == 1 and "<C-p>" or "<S-Tab>"
end, { expr = true, silent = true, desc = "Previous completion item" })

vim.keymap.set("i", "<cr>", function()
	return vim.fn.pumvisible() == 1 and "<C-y>" or "<cr>"
end, { expr = true, silent = true, desc = "Confirm completion" })

vim.keymap.set("i", "<C-Space>", function()
	return vim.fn.pumvisible() == 1 and "<C-e>" or "<C-x><C-o>"
end, { expr = true, silent = true, desc = "Toggle completion" })

------------------- plugins -------------------

vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name = ev.data.spec.name
		local kind = ev.data.kind
		if kind == "install" or kind == "update" then
			if name == "telescope-fzf-native.nvim" then
				vim.system({ "make" }, { cwd = ev.data.path }):wait()
			elseif name == "nvim-treesitter" then
				vim.cmd("TSUpdate")
			end
		end
	end,
})

vim.pack.add({
	"https://github.com/nvim-mini/mini.pairs",
	"https://github.com/nvim-mini/mini.move",
	"https://github.com/nvim-mini/mini.tabline",
	"https://github.com/nvim-mini/mini.bufremove",
	"https://github.com/nvim-mini/mini.comment",
	"https://github.com/nvim-mini/mini.cursorword",
	"https://github.com/nvim-mini/mini.hipatterns",
	"https://github.com/nvim-mini/mini.trailspace",
	"https://github.com/nvim-mini/mini.statusline",
	"https://github.com/nvim-mini/mini.icons",
	"https://github.com/nvim-mini/mini.jump",
	"https://github.com/nvim-mini/mini.splitjoin",
	"https://github.com/nvim-mini/mini.surround",

	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/windwp/nvim-ts-autotag",

	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/mfussenegger/nvim-lint",

	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-telescope/telescope.nvim",
	"https://github.com/nvim-telescope/telescope-fzf-native.nvim",
	"https://github.com/rachartier/tiny-code-action.nvim",

	"https://github.com/MeanderingProgrammer/render-markdown.nvim",
	"https://github.com/chomosuke/typst-preview.nvim",
	"https://github.com/sindrets/winshift.nvim",
	"https://github.com/folke/which-key.nvim",
	"https://github.com/kwkarlwang/bufresize.nvim",
	"https://github.com/lewis6991/gitsigns.nvim",
})

------------------- lsp -------------------

vim.diagnostic.config({ virtual_text = true })

vim.lsp.config.lua_ls = {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim", "MiniStatusline", "MiniTrailspace", "MiniHipatterns", "MiniSplitjoin" },
			},
		},
	},
}

vim.lsp.config.gopls = {
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
			semanticTokens = true,
		},
	},
}

vim.lsp.enable({ "lua_ls", "gopls", "basedpyright", "marksman", "tinymist" })

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)

		-- enabels autocompletion
		if client and client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
		end

		-- removes all builtin lsp mappings
		for _, key in ipairs({ "K", "grn", "gra", "grr", "gri", "gO", "<C-S>" }) do
			pcall(vim.keymap.del, "n", key, { buffer = args.buf })
		end
	end,
})

-- generation of lsp loading status for status line
local lsp_progress = ""
vim.api.nvim_create_autocmd("LspProgress", {
	callback = function(args)
		local val = args.data.params.value
		if val.kind == "end" then
			lsp_progress = ""
		else
			local title = val.title or ""
			local message = val.message or ""
			local percentage = val.percentage and (val.percentage .. "%%") or ""
			lsp_progress =
				string.format("%s %s %s", title, message, percentage):gsub("%s+", " "):gsub("^%s+", ""):gsub("%s+$", "")
		end
		vim.cmd.redrawstatus()
	end,
})

----------- small plugins configuration -----------

require("mini.move").setup()
require("mini.tabline").setup()
require("mini.bufremove").setup()
require("mini.trailspace").setup()
require("mini.jump").setup()
require("winshift").setup()
require("bufresize").setup()
require("render-markdown").setup()
require("typst-preview").setup()
require("gitsigns").setup()

require("mini.splitjoin").setup({
	mappings = {
		toogle = "<leader>a",
	},
})

require("tiny-code-action").setup({
	backend = "delta",
})

require("mini.cursorword").setup({
	delay = 0,
})

require("mini.hipatterns").setup({
	highlighters = {
		fixme = { pattern = "FIXME", group = "MiniHipatternsFixme" },
		hack = { pattern = "HACK", group = "MiniHipatternsHack" },
		todo = { pattern = "TODO", group = "MiniHipatternsTodo" },
		note = { pattern = "NOTE", group = "MiniHipatternsNote" },
		hex_color = require("mini.hipatterns").gen_highlighter.hex_color(),
	},
})

require("mini.comment").setup({
	mappings = {
		comment = "<leader>c",
		comment_line = "<leader>c",
		comment_visual = "<leader>c",
		textobject = "<leader>c",
	},
})

require("mini.icons").setup({
	file = {
		[".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
		["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
	},
	filetype = {
		dotenv = { glyph = "", hl = "MiniIconsYellow" },
	},
})
package.preload["nvim-web-devicons"] = function()
	require("mini.icons").mock_nvim_web_devicons()
	return package.loaded["nvim-web-devicons"]
end

require("mini.surround").setup({
	mappings = {
		add = "<leader>sa",
		delete = "<leader>sd",
		find = "<leader>sf",
		find_left = "<leader>sF",
		highlight = "<leader>sh",
		replace = "<leader>sr",

		suffix_last = "",
		suffix_next = "",
	},
})

require("mini.pairs").setup({
	mappings = {
		["("] = { neigh_pattern = ".[^%w_]" },
		["{"] = { neigh_pattern = ".[^%w_]" },
		["["] = { neigh_pattern = ".[^%w_]" },
		['"'] = { neigh_pattern = ".[^%w_]" },
		["'"] = { neigh_pattern = ".[^%w_]" },
		["`"] = { neigh_pattern = ".[^%w_]" },
	},
	modes = { insert = true, command = true, terminal = false },
	skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
	skip_ts = { "string" },
	skip_unbalanced = true,
	markdown = true,
})

require("mini.statusline").setup({
	content = {
		active = function()
			local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
			local git = MiniStatusline.section_git({ trunc_width = 40 })
			local diff = MiniStatusline.section_diff({ trunc_width = 75 })
			local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
			local filename = MiniStatusline.section_filename({ trunc_width = 140 })
			local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
			local location = MiniStatusline.section_location({ trunc_width = 75 })

			local lsp = lsp_progress ~= "" and lsp_progress or ""

			return MiniStatusline.combine_groups({
				{ hl = mode_hl, strings = { mode } },
				{ hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics } },
				"%<",
				{ hl = "MiniStatuslineFilename", strings = { filename } },
				"%=",
				{ hl = "MiniStatuslineFileinfo", strings = { lsp, fileinfo } },
				{ hl = mode_hl, strings = { location } },
			})
		end,
	},
})

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		go = { "gofmt", "goimports" },
		python = { "ruff_format" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		javascriptreact = { "prettier" },
		typescriptreact = { "prettier" },
		json = { "prettier" },
		html = { "prettier" },
		css = { "prettier" },
		yaml = { "prettier" },
		markdown = { "prettier" },
		typst = { "typstyle" },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})

require("lint").linters_by_ft = {
	go = { "golangcilint" },
	python = { "ruff" },
	markdown = { "markdownlint" },
}

----------- treesitter -----------

local filetypes = {
	"go",
	"lua",
	"vim",
	"vimdoc",
	"query",
	"markdown",
	"markdown_inline",
	"json",
	"yaml",
	"toml",
	"bash",
	"fish",
	"javascript",
	"typescript",
	"tsx",
	"python",
	"css",
	"html",
	"git_config",
	"git_rebase",
	"gitcommit",
	"gitignore",
	"regex",
	"dockerfile",
	"typst",
}

local nvts = require("nvim-treesitter")

nvts.install(filetypes)

nvts.setup({
	highlight = { enable = true },
	indent = { enable = true },
	autotag = { enable = true },
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = filetypes,
	callback = function()
		vim.treesitter.start()
	end,
})

require("nvim-ts-autotag").setup()

----------- telescope -----------

require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<C-j>"] = "move_selection_next",
				["<C-k>"] = "move_selection_previous",
				["<C-h>"] = "results_scrolling_left",
				["<C-l>"] = "results_scrolling_right",
				["<C-y>"] = function(prompt_bufnr)
					local selection = require("telescope.actions.state").get_selected_entry()
					require("telescope.actions").close(prompt_bufnr)
					vim.fn.setreg("+", selection.text or selection.value)
					vim.notify("Copied diagnostic: " .. (selection.text or selection.value))
				end,
				["jk"] = "close",
				["kj"] = "close",
			},
			n = {
				["<C-j>"] = "move_selection_next",
				["<C-k>"] = "move_selection_previous",
				["<C-h>"] = "results_scrolling_left",
				["<C-l>"] = "results_scrolling_right",
				["<C-y>"] = function(prompt_bufnr)
					local selection = require("telescope.actions.state").get_selected_entry()
					require("telescope.actions").close(prompt_bufnr)
					vim.fn.setreg("+", selection.text or selection.value)
					vim.notify("Copied diagnostic: " .. (selection.text or selection.value))
				end,
				["jk"] = "close",
				["kj"] = "close",
			},
		},
	},
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
	},
})
require("telescope").load_extension("fzf")

----------- which key -----------

local wk = require("which-key")

wk.setup({
	preset = "modern",
	notify = true,
	icons = {
		mappings = false,
	},
})

wk.add({
	{ "<leader>c", desc = "[c]omment" },
	{ "<leader>a", MiniSplitjoin.toggle, desc = "split/join [a]rguments" },

	{ "<leader>s", group = "[s]urround", mode = { "n", "v" } },
	{ "<leader>sa", desc = "[a]dd", mode = { "n", "v" } },
	{ "<leader>sd", desc = "[d]elete", mode = { "n", "v" } },
	{ "<leader>sf", desc = "[f]ind right", mode = { "n", "v" } },
	{ "<leader>sF", desc = "[F]ind left", mode = { "n", "v" } },
	{ "<leader>sr", desc = "[r]eplace", mode = { "n", "v" } },
	{ "<leader>sh", desc = "[h]ighlight", mode = { "n", "v" } },

	{ "<leader>w", "<cmd>WinShift<cr>", desc = "move [w]indow" },
	{ "<leader>p", "<cmd>TypstPreviewToggle<cr>", desc = "toggle typst [p]review" },
	{ "<leader>t", MiniTrailspace.trim, desc = "remove [t]railing whitespaces" },
	{ "<leader>e", "<cmd>Explore<cr>", desc = "toggle [e]xplorer" },
	{
		"<leader>x",
		function()
			local bd = require("mini.bufremove").delete
			if bd(0, false) then
				local wins = vim.api.nvim_list_wins()
				if #wins > 1 then
					vim.api.nvim_win_close(0, false)
				end
			end
		end,
		desc = "[x] close buffer",
	},

	{ "<leader>g", group = "[g]it", mode = { "n", "v" } },
	{ "<leader>gs", "<cmd>Gitsigns stage_hunk<cr>", desc = "Stage Hunk", mode = { "n", "v" } },
	{ "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>", desc = "Reset Hunk", mode = { "n", "v" } },
	{ "<leader>gS", "<cmd>Gitsigns stage_buffer<cr>", desc = "Stage Buffer" },
	{ "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<cr>", desc = "Undo Stage Hunk" },
	{ "<leader>gR", "<cmd>Gitsigns reset_buffer<cr>", desc = "Reset Buffer" },
	{ "<leader>gp", "<cmd>Gitsigns preview_hunk_inline<cr>", desc = "Preview Hunk Inline" },
	{
		"<leader>gb",
		function()
			require("gitsigns").blame_line({ full = true })
		end,
		desc = "Blame Line",
	},
	{ "<leader>gB", require("gitsigns").blame, desc = "Blame Buffer" },
	{ "<leader>gd", "<cmd>Gitsigns diffthis<cr>", desc = "Diff This" },
	{
		"<leader>gD",
		function()
			require("gitsigns").diffthis("~")
		end,
		desc = "Diff This ~",
	},

	{ "<leader>gt", group = "[t]oggle", mode = { "n" } },
	{ "<leader>gtb", require("gitsigns").toggle_current_line_blame, desc = "toggle line [b]lame" },
	{ "<leader>gtw", require("gitsigns").toggle_word_diff, desc = "toggle [w]ord diff" },

	{
		"]h",
		function()
			if vim.wo.diff then
				vim.cmd.normal({ "]c", bang = true })
			else
				require("gitsigns").nav_hunk("next")
			end
		end,
		desc = "Next Hunk",
	},
	{
		"[h",
		function()
			if vim.wo.diff then
				vim.cmd.normal({ "[c", bang = true })
			else
				require("gitsigns").nav_hunk("prev")
			end
		end,
		desc = "Prev Hunk",
	},
	{
		"]H",
		function()
			require("gitsigns").nav_hunk("last")
		end,
		desc = "Last Hunk",
	},
	{
		"[H",
		function()
			require("gitsigns").nav_hunk("first")
		end,
		desc = "First Hunk",
	},

	{ "<leader>f", group = "[f]ind", mode = { "n", "v" } },
	{ "<leader>ff", require("telescope.builtin").find_files, desc = "[f]iles" },
	{ "<leader>fw", require("telescope.builtin").live_grep, desc = "[w]ord" },
	{ "<leader>fb", require("telescope.builtin").buffers, desc = "[b]uffers" },
	{ "<leader>fh", require("telescope.builtin").help_tags, desc = "[h]elp" },
	{ "<leader>fk", require("telescope.builtin").keymaps, desc = "[k]eymaps" },
	{ "<leader>fc", require("telescope.builtin").commands, desc = "[c]ommands" },
	{ "<leader>fr", require("telescope.builtin").oldfiles, desc = "[r]ecent files" },
	{ "<leader>fs", require("telescope.builtin").grep_string, desc = "[s]tring under cursor" },
	{ "<leader>fm", require("telescope.builtin").man_pages, desc = "[m]an pages" },
	{
		"<leader>ft",
		function()
			require("telescope.builtin").grep_string({ search = "TODO|FIXME|HACK|NOTE", use_regex = true })
		end,
		desc = "[t]odos",
	},
	{ "<leader>/", require("telescope.builtin").current_buffer_fuzzy_find, desc = "[/] search in current buffer" },

	{ "<leader>l", group = "[l]sp" },
	{ "<leader>ll", require("lint").try_lint, desc = "[l]int" },
	{ "<leader>la", require("tiny-code-action").code_action, desc = "[a]ction" },
	{ "<leader>ld", require("telescope.builtin").lsp_definitions, desc = "[d]efinition" },
	{ "<leader>lx", require("telescope.builtin").diagnostics, desc = "diagnostics" },
	{ "<leader>li", require("telescope.builtin").lsp_implementations, desc = "[i]mplementation" },
	{ "<leader>lr", require("telescope.builtin").lsp_references, desc = "[r]eferences" },
	{ "<leader>ls", require("telescope.builtin").lsp_document_symbols, desc = "document [s]ymbols" },
	{ "<leader>lS", require("telescope.builtin").lsp_dynamic_workspace_symbols, desc = "workspace [S]ymbols" },
	{ "<leader>lh", vim.lsp.buf.hover, desc = "[h]over" },
	{ "<leader>ln", vim.lsp.buf.rename, desc = "re[n]ame" },
	{ "<leader>lk", vim.lsp.buf.signature_help, desc = "signature [k]ey" },
	{ "<leader>lD", vim.lsp.buf.declaration, desc = "[D]eclaration" },
	{
		"<leader>lf",
		function()
			require("conform").format({ async = true, lsp_format = "fallback" })
		end,
		desc = "[f]ormat",
	},
	{
		"<leader>ly",
		function()
			local line = vim.api.nvim_win_get_cursor(0)[1] - 1
			local diags = vim.diagnostic.get(0, { lnum = line })
			if #diags > 0 then
				vim.fn.setreg("+", diags[1].message)
				vim.notify("Copied diagnostic: " .. diags[1].message)
			end
		end,
		desc = "[y]ank diagnostic",
	},
})
