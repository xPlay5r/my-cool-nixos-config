-- :%s/^map/vim.keymap.set
-- :help vim.keymap.set()
vim.g.mapleader = " "
vim.g.maplocalleader = " "
bind = vim.keymap.set

-- Instead of reopening nvim, source config automatically
-- You could also think about this as restart command, with autosave
bind("n", "<leader>r", "<CMD>w|:restart<CR>", { desc = "Source config" })
-- Edit nvim config from anywhere
bind("n", "<C-.>", "<CMD>tabnew ~/.config/nvim/lua/<CR>")

bind("i", "<C-х>", "<C-[>")
bind({ "i", "c" }, "<C-BS>", "<C-w>")

bind("n", "<leader>?", function()
	require("which-key").show({ global = false })
end, { desc = "Buffer Local Keymaps (which-key)" })

-- Yank, paste, delete and change
bind({"n", "x"}, "<leader>y", "\"+y")
bind({"n", "x"}, "<leader>Y", "\"+y$")
bind({"n", "x"}, "<leader>p", "\"+p")
bind({"n", "x"}, "<leader>P", "\"+P")
bind({"n", "x"}, "<leader>d", "\"+d")
bind({"n", "x"}, "<leader>D", "\"+d$")
bind({"n", "x"}, "<leader>c", "\"+c")
bind({"n", "x"}, "<leader>C", "\"+c$")

-- Explorer
bind("n", "<leader>e", function()
	require("oil").toggle_float(nil, nil, function()
		require("oil").open_preview({ preview = { split = "botright" } })
	end)
end, { desc = "Open parent directory" })

-- Notify history
bind("n", "<leader>n", function()
	MiniNotify.show_history()
end,  { desc = "Show notify history" })

-- -- more convenient ':'
-- bind({ "n", "x" }, ";", ":", { desc = "Command-line mode" })
-- bind({ "n", "x" }, ":", ";", { desc = "Next ftFT" })

-- better indenting
bind("v", ">", ">gv")
bind("v", "<", "<gv")

-- commenting
bind("n", "gco", "ox<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
bind("n", "gcO", "Ox<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

-- search result in the middle of screen
bind("n", "n", "nzz")
bind("n", "N", "Nzz")

-- Scroll down and up, convenient in man pages
bind("n", "\\", "0<C-D>zz", { desc = "Scroll down" })
bind("n", "|", "0<C-U>zz", { desc = "Scroll up" })
bind("n", "<BS>", "0<C-U>zz", { desc = "Scroll up" })

bind("n", "<C-D>", "<C-D>zz0", { desc = "Scroll down" })
bind("n", "<C-U>", "<C-U>zz0", { desc = "Scroll up" })

-- Scroll second window within insert mode
bind("i", "<C-f>", "<ESC><C-w><C-w>0<C-d>zz<C-w><C-w>gi" )
bind("i", "<C-b>", "<ESC><C-w><C-w>0<C-u>zz<C-w><C-w>gi" )

-- better up/down
-- bind({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
bind({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
-- bind({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
bind({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Join two lines without jumping to the merge point
bind("n", "J", ":let p=getpos('.')<bar>join<bar>call setpos('.', p)<cr>")

-- Move to window using the <ctrl> hjkl keys
bind("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
bind("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
bind("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
bind("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Resize window using <ctrl> arrow keys
bind("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
bind("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
bind("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
bind("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Move Lines
-- bind("n", "<A-j>", "<cmd>m '>+1<cr>gv=gv", { desc = "Move Down" })
-- bind("n", "<A-k>", "<cmd>m '>-1<cr>gv=gv", { desc = "Move Up" })
-- bind("v", "<A-k>", "<cmd>m '<-2<CR>gv=gv", { desc = "Move Down" })
-- bind("v", "<A-j>", "<cmd>m '>+1<CR>gv=gv", { desc = "Move Up" })

-- buffers
bind("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
bind("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })
bind("n", "<Tab>", "<cmd>tabn<cr>")
bind("n", "<S-Tab>", "<cmd>tabp<cr>")
bind("n", "<C-i>", "<C-i>")

-- Clear search and stop snippet on escape
bind("n", "<esc>", function()
  vim.cmd("noh")
  vim.snippet.stop()
  return "<esc>"
end, { expr = true, desc = "Escape and Clear hlsearch" })

-- save file
bind({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr>", { desc = "Save File" })

-- Add text to the end of line within insert mode
-- (inspired by <M-o> defaulting to <esc>o)
bind("i", "<M-a>", "<ESC>$a") -- too lazy for pressing shift myself
bind("i", "<M-i>", "<ESC>0i")

-- translate
local get_txtobj = function()
	pos1 = vim.fn.getpos("'[")
	pos2 = vim.fn.getpos("']")
	lines = vim.fn.getregion(pos1, pos2)
	text = table.concat(lines, "\n")
	return text
end

_G.my_opfunc_tr = function(vt)
	vim.print(get_txtobj())
end
_G.my_opfunc_te = function(vt)
	vim.print(get_txtobj())
end
_G.my_opfunc_tdr = function(vt)
	vim.print(get_txtobj())
end
_G.my_opfunc_tde = function(vt)
	vim.print(get_txtobj())
end

vim.keymap.set("n", "<leader>l", function()
	vim.opt.operatorfunc = 'v:lua.my_operatorfunc'
	return "g@"
end, { expr = true })
