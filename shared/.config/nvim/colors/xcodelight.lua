vim.cmd("hi clear")
if vim.fn.exists("syntax_on") == 1 then
	vim.cmd("syntax reset")
end
vim.o.background = "light"
vim.g.colors_name = "xcodelight"

local c = {
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
	function_name = "#164E54",
	variable = "#26474B",
	constant = "#02638C",
	type = "#9B2393",
	property = "#0B5561",
	attribute = "#815F03",
	cursor = "#000000",
	selection = "#B2D7FF",
	search = "#fefcbf",
	line_number = "#A6A6A6",
	border = "#D1D1D1",
	error = "#D12F1B",
	warning = "#815F03",
	info = "#02638C",
	hint = "#3900a0",
	git_add = "#1A7F37",
	git_change = "#9A6700",
	git_delete = "#D12F1B",
}

local groups = {
	-- Base UI
	Normal = { fg = c.fg, bg = c.bg },
	NormalFloat = { fg = c.fg, bg = c.bg_light },
	Cursor = { fg = c.bg, bg = c.cursor },
	CursorLine = { bg = c.bg_highlight },
	LineNr = { fg = c.line_number, bg = c.bg },
	SignColumn = { bg = c.bg },
	Visual = { bg = c.selection },
	Search = { fg = c.fg, bg = c.search },
	WinSeparator = { fg = c.bg_dark },
	FloatBorder = { fg = c.border, bg = c.bg_light },
	Directory = { fg = c.type, bold = true },

	-- Pmenu
	Pmenu = { fg = c.fg, bg = c.bg_alt },
	PmenuSel = { fg = c.fg, bg = c.selection },

	-- StatusLine
	StatusLine = { fg = c.fg_dark, bg = c.bg_alt },

	-- Syntax
	Comment = { fg = c.comment, italic = true },
	Constant = { fg = c.constant },
	String = { fg = c.string },
	Number = { fg = c.number },
	Boolean = { fg = c.keyword, bold = true },
	Function = { fg = c.function_name },
	Statement = { fg = c.keyword, bold = true },
	Keyword = { fg = c.keyword, bold = true },
	Type = { fg = c.type },
	PreProc = { fg = c.constant, bold = true },
	Identifier = { fg = c.variable },
	Operator = { fg = c.fg },
	Delimiter = { fg = c.fg },

	-- Treesitter
	["@variable"] = { fg = c.variable },
	["@variable.builtin"] = { fg = c.keyword, bold = true },
	["@variable.parameter"] = { fg = c.fg },
	["@variable.member"] = { fg = c.property },
	["@property"] = { fg = c.property },
	["@tag.attribute"] = { fg = c.attribute },

	-- Diagnostics
	DiagnosticError = { fg = c.error },
	DiagnosticWarn = { fg = c.warning },
	DiagnosticInfo = { fg = c.info },
	DiagnosticHint = { fg = c.hint },

	-- Git
	DiffAdd = { fg = c.git_add, bg = c.bg_highlight },
	DiffChange = { fg = c.git_change, bg = c.bg_highlight },
	DiffDelete = { fg = c.git_delete, bg = c.bg_highlight },
	DiffText = { fg = c.fg, bg = c.selection, bold = true },
	GitSignsAdd = { fg = c.git_add, bg = c.bg },
	GitSignsChange = { fg = c.git_change, bg = c.bg },
	GitSignsDelete = { fg = c.git_delete, bg = c.bg },

	-- Telescope
	TelescopeNormal = { fg = c.fg, bg = c.bg_light },
	TelescopeBorder = { fg = c.border, bg = c.bg_light },
	TelescopeSelection = { fg = c.fg, bg = c.selection, bold = true },
	TelescopeMatching = { fg = c.number, bold = true },

	-- Mini Statusline
	MiniStatuslineModeNormal = { fg = c.bg, bg = c.constant, bold = true },
	MiniStatuslineModeInsert = { fg = c.bg, bg = c.git_add, bold = true },
	MiniStatuslineModeVisual = { fg = c.bg, bg = c.keyword, bold = true },
	MiniStatuslineModeReplace = { fg = c.bg, bg = c.error, bold = true },
	MiniStatuslineModeCommand = { fg = c.bg, bg = c.type, bold = true },
	MiniStatuslineDevinfo = { fg = c.fg_dark, bg = c.bg_alt },
	MiniStatuslineFilename = { fg = c.fg_dark, bg = c.bg_dark, bold = true },
	MiniStatuslineFileinfo = { fg = c.fg_dark, bg = c.bg_alt },
	MiniStatuslineInactive = { fg = c.fg_darker, bg = c.bg_alt },

	-- Mini Tabline
	MiniTablineCurrent = { fg = c.fg, bg = c.bg_dark, bold = true },
	MiniTablineVisible = { fg = c.fg, bg = c.bg_alt },
	MiniTablineHidden = { fg = c.fg_darker, bg = c.bg_alt },
	MiniTablineModifiedCurrent = { fg = c.git_change, bg = c.bg_dark, bold = true },
	MiniTablineModifiedVisible = { fg = c.git_change, bg = c.bg_alt },
	MiniTablineModifiedHidden = { fg = c.git_change, bg = c.bg_alt },
	MiniTablineFill = { bg = c.bg_alt },

	-- Mini Icons
	MiniIconsAzure = { fg = c.constant },
	MiniIconsBlue = { fg = c.number },
	MiniIconsCyan = { fg = c.function_name },
	MiniIconsGreen = { fg = c.git_add },
	MiniIconsGrey = { fg = c.comment },
	MiniIconsOrange = { fg = c.warning },
	MiniIconsPurple = { fg = c.keyword },
	MiniIconsRed = { fg = c.string },
	MiniIconsYellow = { fg = c.git_change },

	-- Mini Hipatterns
	MiniHipatternsFixme = { fg = c.bg, bg = c.error, bold = true },
	MiniHipatternsHack = { fg = c.bg, bg = c.warning, bold = true },
	MiniHipatternsTodo = { fg = c.bg, bg = c.info, bold = true },
	MiniHipatternsNote = { fg = c.bg, bg = c.hint, bold = true },

	-- WhichKey
	WhichKey = { fg = c.keyword, bold = true },
	WhichKeyGroup = { fg = c.type },
	WhichKeyDesc = { fg = c.fg },
	WhichKeySeparator = { fg = c.fg_darker },

	-- TinyCodeAction
	TinyCodeActionNormal = { fg = c.fg, bg = c.bg_light },
	TinyCodeActionBorder = { fg = c.border, bg = c.bg_light },

	-- RenderMarkdown
	RenderMarkdownH1 = { fg = c.keyword, bg = c.bg_highlight, bold = true },
	RenderMarkdownH2 = { fg = c.info, bg = c.bg_highlight, bold = true },
	RenderMarkdownH3 = { fg = c.git_add, bg = c.bg_highlight, bold = true },
	RenderMarkdownH4 = { fg = c.git_change, bg = c.bg_highlight, bold = true },
	RenderMarkdownH5 = { fg = c.string, bg = c.bg_highlight, bold = true },
	RenderMarkdownH6 = { fg = c.attribute, bg = c.bg_highlight, bold = true },
	RenderMarkdownCode = { bg = c.bg_alt },
	RenderMarkdownCodeInline = { bg = c.bg_alt },
	RenderMarkdownBullet = { fg = c.keyword, bold = true },
	RenderMarkdownQuote = { fg = c.comment, italic = true },
	RenderMarkdownDash = { fg = c.bg_dark, bold = true },
	RenderMarkdownLink = { fg = c.info, underline = true, bold = true },
}

for group, opts in pairs(groups) do
	vim.api.nvim_set_hl(0, group, opts)
end
