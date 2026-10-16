-- inspired by https://github.com/if-not-nil/dotfiles/blob/main/.config/nvim/lua/autocommands.lua

local autocmd = vim.api.nvim_create_autocmd

-- highlight text on yank
autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 200,
		})
	end,
})

-- jump to last pos when opening a file
autocmd('BufReadPost', {
	callback = function(args)
		local valid_line = vim.fn.line([['"]]) >= 1 and vim.fn.line([['"]]) < vim.fn.line('$')
		local not_commit = vim.b[args.buf].filetype ~= 'commit'

		if valid_line and not_commit then
			vim.cmd([[normal! g`"]])
		end
	end,
})

autocmd({ "FileType" }, {
	desc = "change behavior of manual windows",
	pattern = "help,qf,netrw,man,mininotify-history",
	callback = function()
		vim.keymap.set("n", "q", "<C-w>q", { buffer = true, desc = "Quit window" })
		vim.keymap.set("n", "<Space>", "<C-d>zz0", {
			buffer = true, desc = "Scroll down", nowait=true, remap=true
		})
		-- Js bc s-space doesnt work, im forced to other mappings
		vim.keymap.set("n", "<C-Space>", "<C-u>zz0", {
			buffer = true, desc = "Scroll up", nowait=true, remap=true
		})
		-- Or you might like <BS> like in info
		vim.keymap.set("n", "<BS>", "<C-u>zz0", {
			buffer = true, desc = "Scroll up", nowait=true, remap=true
		})
		if vim.fn.has("clipboard") then
			vim.keymap.set({ "n", "x" }, "y", "\"+y", { buffer = true, desc = "Yank" })
			vim.keymap.set({ "n", "x" }, "Y", "\"+y$", { buffer = true, desc = "Yank" })
		end
	end,
})

autocmd({ "FileType" }, {
	desc = "change behavior of manual windows",
	pattern = "kitty-scrollback",
	callback = function()
		vim.o.wrap = true
		vim.o.breakindent = false
		vim.wo.breakindentopt = ""
		vim.wo.showbreak = ""
	end,
})

autocmd("TermOpen", {
	pattern = "*",
	callback = function()
		vim.cmd("startinsert") -- Сразу переходить в режим вставки/терминала
		vim.bo.bufhidden = "delete" -- Удалять буфер при закрытии терминала
	end,
})
