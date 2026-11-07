-- vim.cmd("hi clear")
-- if vim.fn.exists("syntax_on") == 1 then
-- 	vim.cmd("syntax reset")
-- end
-- vim.o.background = "light"
-- vim.g.colors_name = "xcodelight"
--
-- local c = {
-- 	bg = "#FFFFFF",
-- 	bg_alt = "#F2F2F2",
-- 	bg_dark = "#E6E6E6",
-- 	bg_light = "#F9F9F9",
-- 	bg_highlight = "#ECF5FF",
-- 	fg = "#000000",
-- 	fg_alt = "#262626",
-- 	fg_dark = "#4D4D4D",
-- 	fg_darker = "#707F8C",
-- 	keyword = "#9B2393",
-- 	string = "#C41A16",
-- 	comment = "#5D6C79",
-- 	number = "#1C00CF",
-- 	function_name = "#164E54",
-- 	variable = "#26474B",
-- 	constant = "#02638C",
-- 	type = "#9B2393",
-- 	property = "#0B5561",
-- 	attribute = "#815F03",
-- 	cursor = "#000000",
-- 	selection = "#B2D7FF",
-- 	search = "#fefcbf",
-- 	line_number = "#A6A6A6",
-- 	border = "#D1D1D1",
-- 	error = "#D12F1B",
-- 	warning = "#815F03",
-- 	info = "#02638C",
-- 	hint = "#3900a0",
-- 	git_add = "#1A7F37",
-- 	git_change = "#9A6700",
-- 	git_delete = "#D12F1B",
-- }
--
-- local groups = {
-- 	-- Base UI
-- 	Normal = { fg = c.fg, bg = c.bg },
-- 	NormalFloat = { fg = c.fg, bg = c.bg_light },
-- 	Cursor = { fg = c.bg, bg = c.cursor },
-- 	CursorLine = { bg = c.bg_highlight },
-- 	LineNr = { fg = c.line_number, bg = c.bg },
-- 	SignColumn = { bg = c.bg },
-- 	Visual = { bg = c.selection },
-- 	Search = { fg = c.fg, bg = c.search },
-- 	WinSeparator = { fg = c.bg_dark },
-- 	FloatBorder = { fg = c.border, bg = c.bg_light },
-- 	Directory = { fg = c.type, bold = true },
--
-- 	-- Pmenu
-- 	Pmenu = { fg = c.fg, bg = c.bg_alt },
-- 	PmenuSel = { fg = c.fg, bg = c.selection },
--
-- 	-- StatusLine
-- 	StatusLine = { fg = c.fg_dark, bg = c.bg_alt },
--
-- 	-- Syntax
-- 	Comment = { fg = c.comment, italic = true },
-- 	Constant = { fg = c.constant },
-- 	String = { fg = c.string },
-- 	Number = { fg = c.number },
-- 	Boolean = { fg = c.keyword, bold = true },
-- 	Function = { fg = c.function_name },
-- 	Statement = { fg = c.keyword, bold = true },
-- 	Keyword = { fg = c.keyword, bold = true },
-- 	Type = { fg = c.type },
-- 	PreProc = { fg = c.constant, bold = true },
-- 	Identifier = { fg = c.variable },
-- 	Operator = { fg = c.fg },
-- 	Delimiter = { fg = c.fg },
--
-- 	-- Treesitter
-- 	["@variable"] = { fg = c.variable },
-- 	["@variable.builtin"] = { fg = c.keyword, bold = true },
-- 	["@variable.parameter"] = { fg = c.fg },
-- 	["@variable.member"] = { fg = c.property },
-- 	["@property"] = { fg = c.property },
-- 	["@tag.attribute"] = { fg = c.attribute },
--
-- 	-- Diagnostics
-- 	DiagnosticError = { fg = c.error },
-- 	DiagnosticWarn = { fg = c.warning },
-- 	DiagnosticInfo = { fg = c.info },
-- 	DiagnosticHint = { fg = c.hint },
--
-- 	-- Git
-- 	DiffAdd = { fg = c.git_add, bg = c.bg_highlight },
-- 	DiffChange = { fg = c.git_change, bg = c.bg_highlight },
-- 	DiffDelete = { fg = c.git_delete, bg = c.bg_highlight },
-- 	DiffText = { fg = c.fg, bg = c.selection, bold = true },
-- 	GitSignsAdd = { fg = c.git_add, bg = c.bg },
-- 	GitSignsChange = { fg = c.git_change, bg = c.bg },
-- 	GitSignsDelete = { fg = c.git_delete, bg = c.bg },
--
-- 	-- Telescope
-- 	TelescopeNormal = { fg = c.fg, bg = c.bg_light },
-- 	TelescopeBorder = { fg = c.border, bg = c.bg_light },
-- 	TelescopeSelection = { fg = c.fg, bg = c.selection, bold = true },
-- 	TelescopeMatching = { fg = c.number, bold = true },
--
-- 	-- Mini Statusline
-- 	MiniStatuslineModeNormal = { fg = c.bg, bg = c.constant, bold = true },
-- 	MiniStatuslineModeInsert = { fg = c.bg, bg = c.git_add, bold = true },
-- 	MiniStatuslineModeVisual = { fg = c.bg, bg = c.keyword, bold = true },
-- 	MiniStatuslineModeReplace = { fg = c.bg, bg = c.error, bold = true },
-- 	MiniStatuslineModeCommand = { fg = c.bg, bg = c.type, bold = true },
-- 	MiniStatuslineDevinfo = { fg = c.fg_dark, bg = c.bg_alt },
-- 	MiniStatuslineFilename = { fg = c.fg_dark, bg = c.bg_dark, bold = true },
-- 	MiniStatuslineFileinfo = { fg = c.fg_dark, bg = c.bg_alt },
-- 	MiniStatuslineInactive = { fg = c.fg_darker, bg = c.bg_alt },
--
-- 	-- Mini Tabline
-- 	MiniTablineCurrent = { fg = c.fg, bg = c.bg_dark, bold = true },
-- 	MiniTablineVisible = { fg = c.fg, bg = c.bg_alt },
-- 	MiniTablineHidden = { fg = c.fg_darker, bg = c.bg_alt },
-- 	MiniTablineModifiedCurrent = { fg = c.git_change, bg = c.bg_dark, bold = true },
-- 	MiniTablineModifiedVisible = { fg = c.git_change, bg = c.bg_alt },
-- 	MiniTablineModifiedHidden = { fg = c.git_change, bg = c.bg_alt },
-- 	MiniTablineFill = { bg = c.bg_alt },
--
-- 	-- Mini Icons
-- 	MiniIconsAzure = { fg = c.constant },
-- 	MiniIconsBlue = { fg = c.number },
-- 	MiniIconsCyan = { fg = c.function_name },
-- 	MiniIconsGreen = { fg = c.git_add },
-- 	MiniIconsGrey = { fg = c.comment },
-- 	MiniIconsOrange = { fg = c.warning },
-- 	MiniIconsPurple = { fg = c.keyword },
-- 	MiniIconsRed = { fg = c.string },
-- 	MiniIconsYellow = { fg = c.git_change },
--
-- 	-- Mini Hipatterns
-- 	MiniHipatternsFixme = { fg = c.bg, bg = c.error, bold = true },
-- 	MiniHipatternsHack = { fg = c.bg, bg = c.warning, bold = true },
-- 	MiniHipatternsTodo = { fg = c.bg, bg = c.info, bold = true },
-- 	MiniHipatternsNote = { fg = c.bg, bg = c.hint, bold = true },
--
-- 	-- WhichKey
-- 	WhichKey = { fg = c.keyword, bold = true },
-- 	WhichKeyGroup = { fg = c.type },
-- 	WhichKeyDesc = { fg = c.fg },
-- 	WhichKeySeparator = { fg = c.fg_darker },
--
-- 	-- TinyCodeAction
-- 	TinyCodeActionNormal = { fg = c.fg, bg = c.bg_light },
-- 	TinyCodeActionBorder = { fg = c.border, bg = c.bg_light },
--
-- 	-- RenderMarkdown
-- 	RenderMarkdownH1 = { fg = c.keyword, bg = c.bg_highlight, bold = true },
-- 	RenderMarkdownH2 = { fg = c.info, bg = c.bg_highlight, bold = true },
-- 	RenderMarkdownH3 = { fg = c.git_add, bg = c.bg_highlight, bold = true },
-- 	RenderMarkdownH4 = { fg = c.git_change, bg = c.bg_highlight, bold = true },
-- 	RenderMarkdownH5 = { fg = c.string, bg = c.bg_highlight, bold = true },
-- 	RenderMarkdownH6 = { fg = c.attribute, bg = c.bg_highlight, bold = true },
-- 	RenderMarkdownCode = { bg = c.bg_alt },
-- 	RenderMarkdownCodeInline = { bg = c.bg_alt },
-- 	RenderMarkdownBullet = { fg = c.keyword, bold = true },
-- 	RenderMarkdownQuote = { fg = c.comment, italic = true },
-- 	RenderMarkdownDash = { fg = c.bg_dark, bold = true },
-- 	RenderMarkdownLink = { fg = c.info, underline = true, bold = true },
-- }
--
-- for group, opts in pairs(groups) do
-- 	vim.api.nvim_set_hl(0, group, opts)
-- end

-- vxcode light for Neovim (port of the VS Code theme)
-- ~/.config/nvim/colors/vxcode-light.lua  ->  :colorscheme vxcode-light
vim.cmd("hi clear")
vim.o.background = "light"
vim.g.colors_name = "vxcode-light"

local c = {
	bg = "#ffffff",
	fg = "#333333",
	fg2 = "#444444",
	dim = "#999999",
	nr = "#aaaaaa",
	panel = "#f9f9fb",
	widget = "#fbfbfb",
	line = "#f6f6f6",
	code = "#e9e9e9",
	border = "#e5e5e5",
	float_border = "#cccccc",
	ws = "#efefef",
	list_sel = "#e7e7e7",
	-- alpha colors from the VS Code theme, pre-blended on white
	sel = "#cde7dd",
	find = "#bcded1",
	find_hl = "#d7ece4",
	bracket = "#e5efe5",
	add_bg = "#e4f2ec",
	del_bg = "#fbefef",
	chg_bg = "#edf2fa",
	txt_bg = "#dbe5f4",
	-- accents
	green = "#26966a",
	red = "#e38181",
	blue = "#7098d4",
	warn = "#d8b544",
	del = "#c55151",
	-- syntax
	comment = "#707F8C",
	keyword = "#AD3DA4",
	string = "#D22E1B",
	number = "#2629D8",
	char = "#c7792b",
	func = "#01638C",
	type = "#4B22B0",
	var = "#8050B8",
	prop = "#3E7E85",
	param = "#23575C",
	quote = "#a0a0a0",
}

local hl = {
	-- editor
	Normal = { fg = c.fg, bg = c.bg },
	NormalNC = { fg = c.fg, bg = c.bg },
	NormalFloat = { fg = c.fg, bg = c.widget },
	FloatBorder = { fg = c.float_border, bg = c.widget },
	FloatTitle = { fg = c.fg2, bg = c.widget, bold = true },
	Cursor = { fg = c.bg, bg = c.red },
	CursorLine = { bg = c.line },
	CursorColumn = { bg = c.line },
	ColorColumn = { bg = c.line },
	CursorLineNr = { fg = c.fg2 },
	LineNr = { fg = c.nr },
	SignColumn = { bg = c.bg },
	FoldColumn = { fg = c.nr, bg = c.bg },
	Folded = { fg = c.dim, bg = c.panel },
	Visual = { bg = c.sel },
	Search = { bg = c.find_hl },
	IncSearch = { bg = c.find },
	CurSearch = { bg = c.find },
	Substitute = { bg = c.find },
	MatchParen = { bg = c.bracket, bold = true },
	NonText = { fg = c.ws },
	Whitespace = { fg = c.ws },
	EndOfBuffer = { fg = c.bg },
	WinSeparator = { fg = c.border },
	Pmenu = { fg = c.fg, bg = c.widget },
	PmenuSel = { bg = c.list_sel },
	PmenuSbar = { bg = c.panel },
	PmenuThumb = { bg = c.border },
	PmenuMatch = { fg = c.green, bold = true },
	StatusLine = { fg = c.fg2, bg = c.bg },
	StatusLineNC = { fg = c.dim, bg = c.bg },
	TabLine = { fg = "#6f6f70", bg = c.panel },
	TabLineSel = { fg = c.fg, bg = c.bg },
	TabLineFill = { bg = c.panel },
	WinBar = { fg = c.dim, bg = c.bg },
	WinBarNC = { fg = c.dim, bg = c.bg },
	Directory = { fg = c.func },
	Title = { fg = c.func, bold = true },
	Question = { fg = c.green },
	MoreMsg = { fg = c.green },
	ModeMsg = { fg = c.fg2 },
	ErrorMsg = { fg = c.red },
	WarningMsg = { fg = c.warn },
	QuickFixLine = { bg = c.list_sel },
	SpellBad = { undercurl = true, sp = c.red },
	SpellCap = { undercurl = true, sp = c.warn },
	SpellRare = { undercurl = true, sp = c.blue },
	SpellLocal = { undercurl = true, sp = c.green },

	-- syntax
	Comment = { fg = c.comment },
	String = { fg = c.string },
	Character = { fg = c.char },
	Number = { fg = c.number },
	Float = { fg = c.number },
	Boolean = { fg = c.keyword },
	Constant = { fg = c.var },
	Identifier = { fg = c.var },
	Function = { fg = c.func },
	Statement = { fg = c.keyword, bold = true },
	Keyword = { fg = c.keyword, bold = true },
	Conditional = { fg = c.keyword, bold = true },
	Repeat = { fg = c.keyword, bold = true },
	Exception = { fg = c.keyword, bold = true },
	Label = { fg = c.dim },
	Operator = { fg = c.keyword, bold = true },
	PreProc = { fg = c.keyword, bold = true },
	Macro = { fg = c.keyword, bold = true }, -- #define in regex syntax
	Type = { fg = c.keyword }, -- regex syntax uses this for int/char
	["@type"] = { fg = c.type }, -- treesitter + LSP types (Client, pthread_mutex_t)
	StorageClass = { fg = c.keyword },
	Structure = { fg = c.keyword },
	Special = { fg = c.func },
	SpecialChar = { fg = c.func },
	Delimiter = { fg = c.fg },
	Underlined = { underline = true },
	Todo = { fg = c.func, bold = true },
	Error = { fg = c.red },

	-- treesitter
	["@variable"] = { fg = c.var },
	["@variable.builtin"] = { fg = c.keyword, italic = true },
	["@variable.parameter"] = { fg = c.param },
	["@variable.member"] = { fg = c.prop },
	["@property"] = { fg = c.prop },
	["@constant"] = { fg = c.var },
	["@constant.builtin"] = { fg = c.keyword },
	["@module"] = { fg = c.type },
	["@label"] = { fg = c.dim },
	["@string.regexp"] = { fg = c.char },
	["@string.escape"] = { fg = c.func },
	["@string.special.url"] = { fg = c.quote, underline = true },
	["@character"] = { fg = c.char },
	["@type.builtin"] = { fg = c.keyword },
	["@constructor"] = { fg = c.type },
	["@function.builtin"] = { fg = c.func },
	["@function.macro"] = { fg = c.func },
	["@constant.macro"] = { fg = c.func },
	["@lsp.type.macro"] = { fg = c.func },
	["@keyword.modifier"] = { fg = c.keyword },
	["@keyword.type"] = { fg = c.keyword },
	["@keyword.directive"] = { fg = c.keyword, bold = true },
	["@punctuation"] = { fg = c.fg },
	["@tag"] = { fg = c.keyword },
	["@tag.builtin"] = { fg = c.keyword },
	["@tag.attribute"] = { fg = c.func },
	["@tag.delimiter"] = { fg = c.fg },
	["@markup.heading"] = { fg = c.string, bold = true },
	["@markup.strong"] = { fg = c.var, bold = true },
	["@markup.italic"] = { fg = c.var, italic = true },
	["@markup.strikethrough"] = { strikethrough = true },
	["@markup.underline"] = { underline = true },
	["@markup.quote"] = { fg = c.quote, italic = true },
	["@markup.raw"] = { fg = c.char },
	["@markup.link"] = { fg = c.func },
	["@markup.link.label"] = { fg = c.func },
	["@markup.link.url"] = { fg = c.quote, underline = true },
	["@markup.list"] = { fg = c.func },
	["@diff.plus"] = { fg = c.green },
	["@diff.minus"] = { fg = c.del },
	["@diff.delta"] = { fg = c.blue },

	-- diagnostics / lsp (conform, nvim-lint, lspconfig, tiny-code-action)
	DiagnosticError = { fg = c.red },
	DiagnosticWarn = { fg = c.warn },
	DiagnosticInfo = { fg = c.blue },
	DiagnosticHint = { fg = c.green },
	DiagnosticOk = { fg = c.green },
	DiagnosticUnderlineError = { undercurl = true, sp = c.red },
	DiagnosticUnderlineWarn = { undercurl = true, sp = "#e7d38f" },
	DiagnosticUnderlineInfo = { undercurl = true, sp = c.blue },
	DiagnosticUnderlineHint = { undercurl = true, sp = c.green },
	DiagnosticUnnecessary = { fg = c.dim },
	LspReferenceText = { bg = c.add_bg },
	LspReferenceRead = { bg = c.add_bg },
	LspReferenceWrite = { bg = c.add_bg },
	LspInlayHint = { fg = c.green, bg = c.find_hl },
	LspCodeLens = { fg = c.dim },
	LspSignatureActiveParameter = { bg = c.find_hl, bold = true },

	-- diff / gitsigns
	DiffAdd = { bg = c.add_bg },
	DiffDelete = { bg = c.del_bg },
	DiffChange = { bg = c.chg_bg },
	DiffText = { bg = c.txt_bg },
	Added = { fg = c.green },
	Changed = { fg = c.blue },
	Removed = { fg = c.del },

	-- mini.*
	MiniTablineCurrent = { fg = c.fg, bg = c.bg, bold = true },
	MiniTablineVisible = { fg = c.fg, bg = c.panel },
	MiniTablineHidden = { fg = "#6f6f70", bg = c.panel },
	MiniTablineModifiedCurrent = { fg = c.red, bg = c.bg, bold = true },
	MiniTablineModifiedVisible = { fg = c.red, bg = c.panel },
	MiniTablineModifiedHidden = { fg = c.red, bg = c.panel },
	MiniTablineFill = { bg = c.panel },
	MiniTablineTabpagesection = { fg = "#000000", bg = "#66b395", bold = true },
	MiniStatuslineModeNormal = { fg = "#000000", bg = "#66b395", bold = true },
	MiniStatuslineModeInsert = { fg = "#000000", bg = c.blue, bold = true },
	MiniStatuslineModeVisual = { fg = "#000000", bg = "#b290ba", bold = true },
	MiniStatuslineModeReplace = { fg = "#000000", bg = "#ff8787", bold = true },
	MiniStatuslineModeCommand = { fg = "#000000", bg = c.warn, bold = true },
	MiniStatuslineModeOther = { fg = "#000000", bg = "#6ab8c0", bold = true },
	MiniStatuslineDevinfo = { fg = c.fg2, bg = c.panel },
	MiniStatuslineFileinfo = { fg = c.fg2, bg = c.panel },
	MiniStatuslineFilename = { fg = c.fg2, bg = c.bg },
	MiniStatuslineInactive = { fg = c.dim, bg = c.bg },
	MiniCursorword = { underline = true, sp = c.green },
	MiniCursorwordCurrent = { underline = true, sp = c.green },
	MiniHipatternsFixme = { fg = "#000000", bg = "#ff8787", bold = true },
	MiniHipatternsHack = { fg = "#000000", bg = c.warn, bold = true },
	MiniHipatternsTodo = { fg = "#000000", bg = c.blue, bold = true },
	MiniHipatternsNote = { fg = "#000000", bg = "#66b395", bold = true },
	MiniTrailspace = { bg = c.red },
	MiniJump = { bg = c.find, sp = c.green, underline = true },
	MiniIconsAzure = { fg = c.blue },
	MiniIconsBlue = { fg = c.number },
	MiniIconsCyan = { fg = c.prop },
	MiniIconsGreen = { fg = c.green },
	MiniIconsGrey = { fg = c.dim },
	MiniIconsOrange = { fg = c.char },
	MiniIconsPurple = { fg = c.keyword },
	MiniIconsRed = { fg = c.string },
	MiniIconsYellow = { fg = "#b5a165" },

	-- telescope
	TelescopeNormal = { fg = c.fg, bg = c.widget },
	TelescopeBorder = { fg = c.float_border, bg = c.widget },
	TelescopeSelection = { bg = c.list_sel },
	TelescopeSelectionCaret = { fg = c.green, bg = c.list_sel },
	TelescopeMatching = { fg = c.green, bold = true },
	TelescopePromptPrefix = { fg = c.green },

	-- which-key
	WhichKey = { fg = c.func },
	WhichKeyGroup = { fg = c.keyword },
	WhichKeyDesc = { fg = c.fg },
	WhichKeySeparator = { fg = c.dim },

	-- render-markdown
	RenderMarkdownCode = { bg = c.code },
	RenderMarkdownCodeInline = { fg = c.char, bg = c.code },
	RenderMarkdownBullet = { fg = c.func },
	RenderMarkdownQuote = { fg = c.quote },
	RenderMarkdownLink = { fg = c.func },
	RenderMarkdownTableHead = { fg = c.float_border },
	RenderMarkdownTableRow = { fg = c.float_border },
}

-- rainbow-delimiters: the theme has 4 bracket colors, so they repeat
local rainbow = { "#b5a165", "#528f77", "#8e7395", "#5a7aaa" }
for i, name in ipairs({ "Red", "Yellow", "Blue", "Orange", "Green", "Violet", "Cyan" }) do
	hl["RainbowDelimiter" .. name] = { fg = rainbow[(i - 1) % 4 + 1] }
end

for i = 1, 6 do
	hl["RenderMarkdownH" .. i .. "Bg"] = { bg = c.del_bg }
end

for k, v in pairs(hl) do
	vim.api.nvim_set_hl(0, k, v)
end

-- :terminal colors
for i, col in ipairs({
	"#555555",
	"#e47474",
	"#66b395",
	"#e2c97e",
	"#7098d4",
	"#b290ba",
	"#6ab8c0",
	"#dddddd",
	"#888888",
	"#f48484",
	"#76c3a5",
	"#f2d98e",
	"#80a8e4",
	"#c2a0ca",
	"#7ac8d0",
	"#eeeeee",
}) do
	vim.g["terminal_color_" .. (i - 1)] = col
end
