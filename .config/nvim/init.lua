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
vim.opt.listchars = {tab = "» ", trail = "·", nbsp = "␣"}
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.completeopt = "menu,menuone,noselect"
vim.o.softtabstop = 2

-- hide the mode
vim.o.showmode = false

-- enables clipboard syncing between nvim and system
vim.schedule(
    function()
        vim.o.clipboard = vim.env.SSH_CONNECTION and "" or "unnamedplus"
    end
)

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
vim.api.nvim_create_autocmd(
    "TextYankPost",
    {
        desc = "highlight when yanking text",
        group = vim.api.nvim_create_augroup("highlight-yank", {clear = true}),
        callback = function()
            vim.hl.on_yank()
        end
    }
)

-- Restore last cursor position
vim.api.nvim_create_autocmd(
    "BufWinEnter",
    {
        callback = function(ev)
            local lastpos = vim.api.nvim_buf_get_mark(ev.buf, '"')
            if
                vim.wo.diff or
                    ({
                        gitcommit = true,
                        gitrebase = true,
                        xxd = true
                    })[vim.bo[ev.buf].filetype]
             then
                return
            end
            if pcall(vim.api.nvim_win_set_cursor, 0, lastpos) then
                vim.cmd("normal! zz")
            end
        end
    }
)

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
    selection = "#B2D7FF"
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
    -- Base UI
    Normal = {fg = colors.fg, bg = colors.bg},
    CursorLine = {bg = colors.cursor_l},
    Visual = {bg = colors.selection},
    LineNr = {fg = colors.line_nr},
    VertSplit = {fg = colors.border},
    -- Standard Syntax
    Comment = {fg = colors.comment, italic = true},
    String = {fg = colors.string},
    Keyword = {fg = colors.keyword, bold = true},
    Function = {fg = colors.func},
    Type = {fg = colors.type},
    Constant = {fg = colors.const},
    -- Tree-sitter Support
    ["@method"] = {fg = colors.func},
    ["@parameter"] = {fg = colors.fg},
    ["@variable"] = {fg = colors.fg},
    ["@variable.builtin"] = {fg = colors.const},
    ["@tag"] = {fg = colors.keyword},
    ["@keyword.return"] = {fg = colors.keyword, bold = true}
}

-- Apply Highlights
for group, settings in pairs(groups) do
    vim.api.nvim_set_hl(0, group, settings)
end

------------------- keys -------------------

vim.g.mapleader = " "
vim.g.maplocalleader = " "

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
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", {desc = "Exit terminal mode"})

-- better splits navigation
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", {desc = "Move focus to the left window"})
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", {desc = "Move focus to the right window"})
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", {desc = "Move focus to the lower window"})
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", {desc = "Move focus to the upper window"})

-- TODO: WINDOW MOVING
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

------------------- plugins -------------------

vim.pack.add(
    {
        "https://github.com/nvim-mini/mini.pairs",
        "https://github.com/nvim-mini/mini.move",
        "https://github.com/nvim-mini/mini.tabline",
        "https://github.com/nvim-mini/mini.bufremove",
        "https://github.com/nvim-mini/mini.comment",
        "https://github.com/nvim-tree/nvim-web-devicons",
        "https://github.com/folke/which-key.nvim",
        "https://github.com/nvim-tree/nvim-tree.lua",
    }
)

require("nvim-web-devicons").setup()

require("mini.pairs").setup()
require("mini.move").setup()
require("mini.tabline").setup()
require("mini.bufremove").setup()

require("mini.comment").setup(
    {
        mappings = {
            comment = "<leader>c",
            comment_line = "<leader>c",
            comment_visual = "<leader>c",
            textobject = "<leader>c"
        }
    }
)

local which_key = require("which-key")

which_key.setup(
    {
        preset = "modern",
        notify = true,
        spec = {
            {"<leader>s", group = "[S]earch", mode = {"n", "v"}},
            {"<leader>t", group = "[T]oggle"},
            {"<leader>h", group = "Git [H]unk", mode = {"n", "v"}},
            {"<leader>b", group = "[B]uffers"}
        }
    }
)

which_key.add(
    {
        {
            "<leader>bc",
            function()
                MiniBufremove.delete()
            end,
            desc = "[C]lose Current Buffer"
        },
        {
            "<leader>c",
            desc = "[C]omment"
        },
        { '<leader>e', '<cmd>NvimTreeToggle<CR>', { silent = true }},
    }
)


require("nvim-tree").setup(
    {
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
                        height = window_h_int
                    }
                end
            },
            width = function()
                return math.floor(vim.opt.columns:get() * 0.8)
            end
        },
        actions = {
            open_file = {
                window_picker = {
                    enable = false
                }
            }
        },
        filters = {
            dotfiles = false,
            git_ignored = false
        },
        renderer = {
            indent_width = 4
        }
    }
)

