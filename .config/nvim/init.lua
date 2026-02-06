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

-- for nvimtree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

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

-- Xcode Light Color Palette
local colors = {
	bg = "#FFFFFF",
	fg = "#000000",
	keyword = "#9B2393",
	string = "#C41A16",
	comment = "#5D6C79",
	func = "#326D74",
	type = "#1C00CF",
	const = "#A90D91",
	border = "#E0E0E0",
	line_nr = "#A2A2A2",
	cursor_l = "#F4F4F4",
	selection = "#B2D7FF",
}

-- Editor Settings
vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
	vim.cmd("syntax reset")
end
vim.g.colors_name = "xcode-light"
vim.o.background = "light"
vim.o.termguicolors = true

local groups = {
	Normal = { fg = colors.fg, bg = colors.bg },
	CursorLine = { bg = colors.cursor_l },
	Visual = { bg = colors.selection },
	LineNr = { fg = colors.line_nr },
	VertSplit = { fg = colors.border },
	FloatBorder = { fg = colors.border, bg = colors.bg },
	NormalFloat = { fg = colors.fg, bg = colors.bg },

	Comment = { fg = colors.comment, italic = true },
	String = { fg = colors.string },
	Keyword = { fg = colors.keyword, bold = true },
	Function = { fg = colors.func },
	Type = { fg = colors.type },
	Constant = { fg = colors.const },

	-- Tree-sitter
	["@variable"] = { fg = colors.fg },
	["@variable.builtin"] = { fg = colors.keyword },
	["@variable.member"] = { fg = colors.fg },
	["@variable.parameter"] = { fg = colors.fg },
	["@function"] = { fg = colors.func },
	["@function.builtin"] = { fg = colors.func, bold = true },
	["@function.call"] = { fg = colors.func },
	["@function.method"] = { fg = colors.func },
	["@function.method.call"] = { fg = colors.func },
	["@constructor"] = { fg = colors.type },
	["@keyword"] = { fg = colors.keyword, bold = true },
	["@keyword.function"] = { fg = colors.keyword },
	["@keyword.operator"] = { fg = colors.keyword },
	["@keyword.return"] = { fg = colors.keyword },
	["@keyword.directive"] = { fg = colors.keyword },
	["@keyword.import"] = { fg = colors.keyword },
	["@string"] = { fg = colors.string },
	["@string.special"] = { fg = colors.string },
	["@string.regexp"] = { fg = colors.string },
	["@type"] = { fg = colors.type },
	["@type.builtin"] = { fg = colors.type },
	["@property"] = { fg = colors.fg },
	["@attribute"] = { fg = colors.func },
	["@module"] = { fg = colors.fg },
	["@constant"] = { fg = colors.const },
	["@constant.builtin"] = { fg = colors.const },
	["@boolean"] = { fg = colors.const },
	["@number"] = { fg = colors.type },
	["@number.float"] = { fg = colors.type },
	["@operator"] = { fg = colors.fg },
	["@punctuation.delimiter"] = { fg = colors.fg },
	["@punctuation.bracket"] = { fg = colors.fg },
	["@punctuation.special"] = { fg = colors.keyword },
	["@tag"] = { fg = colors.keyword },
	["@tag.attribute"] = { fg = colors.func },
	["@tag.delimiter"] = { fg = colors.fg },
	["@label"] = { fg = colors.fg },

	-- Markup (Markdown)
	["@markup.strong"] = { bold = true },
	["@markup.italic"] = { italic = true },
	["@markup.strikethrough"] = { strikethrough = true },
	["@markup.underline"] = { underline = true },
	["@markup.heading"] = { fg = colors.keyword, bold = true },
	["@markup.raw"] = { fg = colors.string },
	["@markup.link"] = { fg = colors.type, underline = true },
	["@markup.link.label"] = { fg = colors.type },
	["@markup.link.url"] = { fg = colors.comment, underline = true },
	["@markup.list"] = { fg = colors.keyword },

	-- LSP Semantic Tokens
	["@lsp.type.variable"] = { link = "@variable" },
	["@lsp.type.parameter"] = { link = "@variable.parameter" },
	["@lsp.type.function"] = { link = "@function" },
	["@lsp.type.method"] = { link = "@function.method" },
	["@lsp.type.class"] = { link = "@type" },
	["@lsp.type.interface"] = { link = "@type" },
	["@lsp.type.struct"] = { link = "@type" },
	["@lsp.type.enum"] = { link = "@type" },
	["@lsp.type.property"] = { link = "@property" },
	["@lsp.type.namespace"] = { link = "@module" },
	["@lsp.type.type"] = { link = "@type" },
	["@lsp.type.enumMember"] = { link = "@constant" },
	["@lsp.type.keyword"] = { link = "@keyword" },

	-- Diagnostics
	DiagnosticError = { fg = "#D12F1B" },
	DiagnosticWarn = { fg = "#704B00" },
	DiagnosticInfo = { fg = "#326D74" },
	DiagnosticHint = { fg = "#5D6C79" },
	DiagnosticUnderlineError = { undercurl = true, sp = "#D12F1B" },
	DiagnosticUnderlineWarn = { undercurl = true, sp = "#704B00" },
	DiagnosticUnderlineInfo = { undercurl = true, sp = "#326D74" },
	DiagnosticUnderlineHint = { undercurl = true, sp = "#5D6C79" },

	-- Diff
	diffAdded = { fg = colors.string },
	diffRemoved = { fg = "#D12F1B" },
	diffChanged = { fg = colors.type },
	diffOldFile = { fg = colors.comment },
	diffNewFile = { fg = colors.string },
	diffFile = { fg = colors.keyword },
	diffLine = { fg = colors.comment },

	-- Telescope
	TelescopeBorder = { fg = colors.border },
	TelescopePromptBorder = { fg = colors.border },
	TelescopeResultsBorder = { fg = colors.border },
	TelescopePreviewBorder = { fg = colors.border },
	TelescopeMatching = { fg = colors.keyword, bold = true },
	TelescopeSelection = { bg = colors.selection },

	Pmenu = { bg = colors.bg, fg = colors.fg },
	PmenuSel = { bg = colors.selection, fg = colors.fg, bold = true },
	PmenuKind = { bg = colors.bg, fg = colors.func },
	PmenuExtra = { bg = colors.bg, fg = colors.comment },
	PmenuSbar = { bg = colors.bg },
	PmenuThumb = { bg = colors.border },

	MiniTablineActive = { fg = colors.fg, bg = colors.bg, bold = true },
	MiniTablineVisible = { fg = colors.comment, bg = colors.cursor_l },
	MiniTablineHidden = { fg = colors.line_nr, bg = colors.cursor_l },
	MiniTablineModifiedActive = { fg = colors.string, bg = colors.bg, bold = true },
	MiniTablineModifiedVisible = { fg = colors.string, bg = colors.cursor_l },
	MiniTablineModifiedHidden = { fg = colors.string, bg = colors.cursor_l },
	MiniTablineFill = { bg = colors.cursor_l },

	MiniStatuslineModeNormal = { fg = colors.bg, bg = colors.func, bold = true },
	MiniStatuslineModeInsert = { fg = colors.bg, bg = colors.string, bold = true },
	MiniStatuslineModeVisual = { fg = colors.bg, bg = colors.keyword, bold = true },
	MiniStatuslineModeReplace = { fg = colors.bg, bg = colors.const, bold = true },
	MiniStatuslineModeCommand = { fg = colors.bg, bg = colors.type, bold = true },

	MiniStatuslineDevinfo = { fg = colors.comment, bg = colors.border },
	MiniStatuslineFilename = { fg = colors.fg, bg = colors.border },
	MiniStatuslineFileinfo = { fg = colors.comment, bg = colors.cursor_l },
	MiniStatuslineInactive = { fg = colors.line_nr, bg = colors.cursor_l },
}

-- Apply Highlights
for group, settings in pairs(groups) do
	vim.api.nvim_set_hl(0, group, settings)
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
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- better splits navigation
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- buffer navigation
vim.keymap.set("n", "{", "<cmd>bprev<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "}", "<cmd>bnext<CR>", { desc = "Next buffer" })

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

vim.keymap.set("i", "<CR>", function()
	return vim.fn.pumvisible() == 1 and "<C-y>" or "<CR>"
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

	"https://github.com/folke/which-key.nvim",
	"https://github.com/nvim-tree/nvim-tree.lua",

	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/windwp/nvim-ts-autotag",

	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/mfussenegger/nvim-lint",

	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-telescope/telescope.nvim",
	"https://github.com/nvim-telescope/telescope-fzf-native.nvim",
	"https://github.com/rachartier/tiny-code-action.nvim",
})

------------------- lsp -------------------

vim.diagnostic.config({ virtual_text = true })

vim.lsp.config.lua_ls = {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim", "MiniStatusline", "MiniTrailspace", "MiniHipatterns" },
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

vim.lsp.enable({ "lua_ls", "gopls", "basedpyright" })

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
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})

require("lint").linters_by_ft = {
	go = { "golangcilint" },
	python = { "ruff" },
}

require("nvim-tree").setup({
	view = {
		float = {
			enable = true,
			open_win_config = function()
				local screen_w = vim.opt.columns:get()
				local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
				local window_w = screen_w * 0.6
				local window_h = screen_h * 0.6
				local window_w_int = math.floor(window_w)
				local window_h_int = math.floor(window_h)
				local center_x = (screen_w - window_w) / 2
				local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
				return {
					border = "rounded",
					relative = "editor",
					row = center_y,
					col = center_x,
					width = window_w_int,
					height = window_h_int,
				}
			end,
		},
		width = function()
			return math.floor(vim.opt.columns:get() * 0.8)
		end,
	},
	actions = {
		open_file = {
			window_picker = {
				enable = false,
			},
		},
	},
	filters = {
		dotfiles = false,
		git_ignored = false,
	},
	renderer = {
		indent_width = 4,
	},
})

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
	{ "<leader>f", group = "[f]ind", mode = { "n", "v" } },
	{ "<leader>ff", require("telescope.builtin").find_files, desc = "[f]iles" },
	{ "<leader>fw", require("telescope.builtin").live_grep, desc = "[w]ord" },
	{ "<leader>fb", require("telescope.builtin").buffers, desc = "[b]uffers" },
	{ "<leader>fh", require("telescope.builtin").help_tags, desc = "[h]elp" },
	{ "<leader>fk", require("telescope.builtin").keymaps, desc = "[k]eymaps" },
	{ "<leader>fc", require("telescope.builtin").commands, desc = "[c]ommands" },
	{ "<leader>fr", require("telescope.builtin").oldfiles, desc = "[r]ecent files" },
	{ "<leader>fs", require("telescope.builtin").grep_string, desc = "[s]tring under cursor" },
	{
		"<leader>ft",
		function()
			require("telescope.builtin").grep_string({
				search = "TODO|FIXME|HACK|NOTE",
				use_regex = true,
			})
		end,
		desc = "[t]odos",
	},
	{
		"<leader>/",
		require("telescope.builtin").current_buffer_fuzzy_find,
		desc = "[/] Fuzzily search in current buffer",
	},

	{ "<leader>h", group = "git [h]unk", mode = { "n", "v" } },

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
		desc = "close buffer",
	},

	{ "<leader>c", desc = "[c]omment" },
	{ "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "toggle [e]xplorer" },
	{ "<leader>t", MiniTrailspace.trim, desc = "remove [t]railing whitespaces" },

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
