-- :help options
vim.o.autochdir = true
vim.o.belloff = ""
vim.o.errorbells = true
vim.o.visualbell = false
vim.o.cursorline = false
-- vim.o.cmdheight = 0

vim.o.langmap = "йцукенгшщзхъфывапролджэячсмитьбюЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ;qwertyuiop[]asdfghjkl\\;'zxcvbnm\\,.QWERTYUIOP{}ASDFGHJKL:\\\"ZXCVBNM<>"

vim.o.number = true
vim.o.cursorline = true
vim.o.relativenumber = true
vim.o.scrolloff = 10

vim.opt.undofile = true
vim.o.winborder = "rounded"

vim.o.foldenable = false

vim.opt.listchars = {
	tab = '│ ',
	lead = '·',
	trail = '·',
	extends = '>',
	precedes = '<',
}

vim.o.wrap = false
vim.o.expandtab = false
vim.o.shiftwidth = 0 -- use tabstop value
vim.opt.tabstop = 4     -- '\t' will be displayed as {n} spaces
-- vim.opt.softtabstop = shiftwidth -- <Tab> will insert {n} spaces
vim.o.breakindent = true
vim.wo.showbreak = "↪"
vim.wo.breakindentopt = "sbr,min:10"

vim.api.nvim_set_hl(0, "MyAccentColor", { fg = "#1010e0" })
