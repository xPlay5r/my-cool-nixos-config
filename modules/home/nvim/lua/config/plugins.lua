-- !ПРЕДПУПРЕЖДЕНИЕ
-- этот файл сейчас не участвует в конфигурации neovim через nix, и не будет.
-- Я его оставил, чтобы переносить старый конфиг на nix

-- disable some features in tty
local is_tty = vim.fn.expand '$TERM' == "linux"

--[[
  -- BUILD HOOKS
--]]

-- :help vim.pack
local vimpack_hooks = function(ev)
	-- Use available |event-data|
	local name, kind = ev.data.spec.name, ev.data.kind

	-- build script after plugin's code has changed
	if name == 'nvim-treesitter' and (kind == 'install' or kind == 'update') then
		if not ev.data.active then
			vim.cmd.packadd('nvim-treesitter')
		end
		vim.cmd("TSUpdate")
		require('nvim-treesitter').after_update()
	end

	-- build script
	if name == 'omega' and (kind == 'install' or kind == 'update') then
		vim.fn.system("cd rs && cargo build --release")
	end

	if name == "firenvim" and (kind == 'install' or kind == 'update') then
		vim.cmd("call firenvim#install(0)")
	end
end
vim.api.nvim_create_autocmd('PackChanged', { callback = vimpack_hooks })


--[[
  -- PACKAGES
--]]

-- :help vim.pack-examples

vim.pack.add({
	"https://github.com/L3MON4D3/LuaSnip",         -- snippet engine
	"https://github.com/folke/neodev.nvim",
	"https://github.com/folke/tokyonight.nvim",
	"https://github.com/nvim-lualine/lualine.nvim",
	"https://github.com/folke/which-key.nvim",
	"https://github.com/glacambre/firenvim", -- nvim in browser
	"https://github.com/mikesmithgh/kitty-scrollback.nvim", -- nvim in kitty
	"https://github.com/hrsh7th/cmp-buffer",       -- buffer words
	"https://github.com/hrsh7th/cmp-cmdline",      -- command-line completions
	"https://github.com/hrsh7th/cmp-nvim-lsp",     -- LSP completions
	"https://github.com/hrsh7th/cmp-path",         -- filesystem paths
	"https://github.com/hrsh7th/nvim-cmp",         -- autocompletions
	"https://github.com/j-hui/fidget.nvim",
	"https://github.com/jessekelighine/vindent.nvim",
	"https://github.com/lukas-reineke/indent-blankline.nvim",
	"https://github.com/mfussenegger/nvim-dap",
	"https://github.com/mfussenegger/nvim-dap-python",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/niuiic/omega.nvim",
	"https://github.com/niuiic/translate.nvim",
	"https://github.com/nvim-neotest/nvim-nio",
	"https://github.com/nvim-treesitter/nvim-treesitter" ,
	"https://github.com/rafamadriz/friendly-snippets", -- VSCode like snippets
	"https://github.com/rcarriga/nvim-dap-ui",
	"https://github.com/saadparwaiz1/cmp_luasnip", -- snippet completions
	"https://github.com/stevearc/overseer.nvim",
	"https://github.com/theHamsta/nvim-dap-virtual-text",
	"https://github.com/williamboman/mason-lspconfig.nvim",
	"https://github.com/williamboman/mason.nvim",
	"https://github.com/windwp/nvim-autopairs",
	'https://github.com/nvim-mini/mini.nvim',
	'https://github.com/stevearc/oil.nvim',
	-- "https://github.com/hiphish/rainbow-delimiters.nvim",
})

require("kitty-scrollback").setup()
require("fidget").setup({})
require("mini.cmdline").setup({}) -- ':' tweaks
require("mini.comment").setup({}) -- gc comments lines
-- require("mini.cursorword").setup({}) -- Autohighlight word under cursor
require("mini.extra").setup({}) -- more textobjects
require("mini.hipatterns").setup({}) -- highlight text patterns, such as colors
require("mini.icons").setup({}) -- nerdfont text icons!
require("mini.move").setup({}) -- Alt + hjkl moves the selection
require("mini.pairs").setup({}) -- ')' automatically adds after '('
require("mini.splitjoin").setup({})
require("nvim-autopairs").setup({})
require("nvim-dap-virtual-text").setup({})
require("nvim-treesitter").setup({})

require("which-key").setup({
	win = {
		no_overlap = false,
		width = 80,
		-- height = { min = 4, max = 25 },
		col = math.huge,
		row = math.huge,
		border = "rounded",
		padding = { 0, 1 },
		title_pos = "left",
		wo = {
			-- winblend = 10
		},
	},
	layout = {
		width = { max = 40 }, -- min and max width of the columns
		spacing = 2, -- spacing between columns
	}
})

require("mini.notify").setup({
	window = {
		-- :h nvim_open_win()
		config = {
			focusable = true,
			border = "rounded",
			zindex = 100,
		},
		winblend = 0,
	},
	lsp_progress = {
		enable = false
	}
})

require("mini.surround").setup({
	mappings = {
		add = 'ys', -- Add surrounding in Normal and Visual modes
		delete = 'ds', -- Delete surrounding
		find = '', -- Find surrounding (to the right)
		find_left = '', -- Find surrounding (to the left)
		highlight = '', -- Highlight surrounding
		replace = 'cs', -- Change surrounding

		suffix_last = 'l', -- Suffix to search with "prev" method
		suffix_next = 'n', -- Suffix to search with "next" method
	},
	custom_surroundings = {
		-- dictionary or list
		-- searches for:
		-- 'something = []' or 'smth={}'
		d = {
			input = {
				{
					"%f[%w_%.%[%]][%w_%.%[%]]+%s*=%s*%b[]", -- or
					"%f[%w_%.%[%]][%w_%.%[%]]+%s*=%s*%b{}"
				}, -- and
				"^.-%s*=%s*[%[%{]%s*().-()%s*[%]%}]$"
			},
			output = function()
				local dict_name = vim.pesc(vim.fn.input("Dictionary name: "))
				return { left = dict_name .. " = {", right = "}" }
			end
		},
		-- python f-string or bash $''
		Q = {
			input = function()
				ft = vim.o.ft
				if ft == "python" then
					return { { 'f%b""', "f%b''" }, '^f.().*().$' }
				elseif ft == "bash" then
					return { { '%$%b""', "%$%b''" }, '^..().*().$' }
				end
			end,
			output = function()
				ft = vim.o.ft
				-- vim.print(ft)
				if ft == "python" then
					return { left = 'f"', right = '"' }
				elseif ft == "bash" then
					return { left = "$'", right = "'" }
				end
			end
		},
		-- shell group $()
		g = {
			input = { '%$%b()', "^..%s*().-()%s*.$" },
			output = { left = '$( ', right = ' )' }
		},
		G = {
			input = { '%$%b{}', "^..%s*().-()%s*.$" },
			output = { left = '${', right = '}' }
		},
		-- equals ___ = smth
		e = {
			input = { '^.*=.*$', '^%s*().-()%s*=%s*.-$' },
			output = function()
				local eq_key = vim.pesc(vim.fn.input("Variable name: "))
				ft = vim.o.ft -- filetype
				if ft == "bash" or ft == "sh" then
					eq_txt = "="
				else
					eq_txt = " = "
				end
				return { left = eq_key .. eq_txt, right = "" }
			end
		},
		-- equals smth = ___
		E = {
			input = { '^.*=.*$', '^%s*.-%s*=%s*().-()$' },
			output = function()
				local eq_val = vim.pesc(vim.fn.input("Value of variable: "))
				ft = vim.o.ft -- filetype
				if ft == "bash" or ft == "sh" then
					eq_txt = "="
				else
					eq_txt = " = "
				end
				return { left = "", right = eq_txt .. eq_val }
			end
		}
	},
	search_method = 'cover_or_next'
})

require("mini.operators").setup({
	-- Evaluate text and replace with output
	evaluate = { prefix = 'c=' },

	-- Exchange text regions
	exchange = { prefix = 'cx', reindent_linewise = true },

	-- Multiply (duplicate) text
	multiply = { prefix = 'cm' },

	-- Replace text with register
	replace = { prefix = 'cr', reindent_linewise = true },

	-- Sort text
	sort = { prefix = 'gs' }
})

-- Remap adding surrounding to Visual mode selection
vim.keymap.del('x', 'ys')
vim.keymap.set('x', 'S', [[:<C-u>lua MiniSurround.add('visual')<CR>]], { silent = true })

-- Make special mapping for "add surrounding for line"
vim.keymap.set('n', 'yss', 'ys_', { remap = true })

vim.keymap.set('n', 'yS', 'ys$', { remap = true })

local MiniAi = require("mini.ai")
local gen_ai_spec = require('mini.extra').gen_ai_spec
MiniAi.setup({
	custom_textobjects = {
		-- python f-string or bash $''
		Q = function()
			ft = vim.o.ft
			if ft == "python" then
				return { { 'f%b""', "f%b''" }, '^f.().*().$' }
			elseif ft == "bash" then
				return { { '%$%b""', "%$%b''" }, '^..().*().$' }
			end
		end,
		-- subshell/group
		g = { '%$%b()', "^..%s*().-()%s*.$" },
		G = { '%$%b{}', "^..%s*().-()%s*.$" },
		-- lua/python/c dictionary or list
		d = {
			{
				"%f[%w_%.%[%]][%w_%.%[%]]+%s*=%s*%b[]", -- or
				"%f[%w_%.%[%]][%w_%.%[%]]+%s*=%s*%b{}"
			}, -- and
			"^.-%s*=%s*[%[%{]().*()[%]%}]$"
		},
		-- equals ___ = smth
		e = { '^.*=.*$', '^%s*().-()%s*=%s*.-$' },
		-- equals smth = ___
		E = { '^.*=.*$', '^%s*.-%s*=%s*().-().$' },

		-- Tweak function call to not detect dot in function name
		f = MiniAi.gen_spec.function_call({ name_pattern = '[%w_%.:]' }),
		A = gen_ai_spec.buffer(),
		D = gen_ai_spec.diagnostic(),
		N = gen_ai_spec.number(),
		L = MiniExtra.gen_ai_spec.line(),
	}
})

local indent_char = is_tty and "▌" or "▎"
require("ibl").setup({
	scope = {
		highlight = "MyAccentColor",
		show_start = false,
		show_end = false
	},
	indent = { char = indent_char }
})
require("mini.indentscope").setup({ symbol = indent_char })
vim.api.nvim_create_autocmd("BufEnter", {
	desc = "Change hl only after entering buffer so changes get applied",
	callback = function(_)
		vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg="#1010e0" })
	end
})

-- Jump to previous/next block with same indentation with [=/]=.
-- Jump to previous/next line with less indentation with [-/]-.
-- Jump to previous/next line with more indentation with [+/]+.
-- Jump to previous/next line with different indentation with [;/];.
-- Jump to start/end of text block with [p/]p or [P/]P.
-- Select text block with ii/iI (in indent),ai (an indent), aI (an Indent)
local vindent = require("vindent")
local block_opts = {
	strict     = {
		skip_empty_lines = false,
		skip_more_indented_lines = false
	},
	contiguous = {
		skip_empty_lines = false,
		skip_more_indented_lines = true
	},
	loose      = {
		skip_empty_lines = true,
		skip_more_indented_lines = true
	},
}
vindent.map.BlockMotion({ prev = "[=", next = "]=" }, block_opts.strict)
vindent.map.Motion({ prev = "[-", next = "]-" }, "less")
vindent.map.Motion({ prev = "[+", next = "]+" }, "more")
vindent.map.Motion({ prev = "[;", next = "];" }, "diff")
vindent.map.BlockEdgeMotion({ prev = "[p", next = "]p" }, block_opts.loose)
vindent.map.BlockEdgeMotion({ prev = "[P", next = "]P" }, block_opts.contiguous)
vindent.map.Object("iI", "ii", block_opts.strict)
vindent.map.Object("ii", "ii", block_opts.loose)
vindent.map.Object("ai", "ai", block_opts.loose)
vindent.map.Object("aI", "aI", block_opts.loose)
vim.g.vindent_begin = false

local function trans_to_ru(my_input, my_output)
	require("translate").translate({
		get_command = function(input)
			return {
				"trans",
				"-e",
				"bing",
				"-b",
				":ru",
				input,
			}
		end,
		-- input | clipboard | selection
		input = my_input,
		-- open_float | notify | copy | insert | replace
		output = { my_output },
		resolve_result = function(result)
			if result.code ~= 0 then
				return nil
			end

			return string.match(result.stdout, "(.*)\n")
		end,
	})
end
local function trans_to_en(my_input, my_output)
	require("translate").translate({
		get_command = function(input)
			return {
				"trans",
				"-e",
				"bing",
				"-b",
				":en",
				input,
			}
		end,
		input = my_input,
		output = { my_output },
		resolve_result = function(result)
			if result.code ~= 0 then
				return nil
			end

			return string.match(result.stdout, "(.*)\n")
		end,
	})
end

vim.keymap.set("n", "<leader>tr", function()
	trans_to_ru("input", "open_float")
end, { desc = "Translate input to russia"})
vim.keymap.set("n", "<leader>te", function()
	trans_to_en("input", "open_float")
end, { desc = "Translate input to english"})
vim.keymap.set("v", "<leader>tr", function()
	trans_to_ru("selection", "open_float")
end, { desc = "Translate input to russia"})
vim.keymap.set("v", "<leader>te", function()
	trans_to_en("selection", "open_float")
end, { desc = "Translate input to english"})
vim.keymap.set("i", "<a-t>r", function()
	trans_to_ru("input", "insert")
end, { desc = "Translate input to russia"})
vim.keymap.set("i", "<a-t>e", function()
	trans_to_en("input", "insert")
end, { desc = "Translate input to english"})

if not is_tty then
	require("tokyonight").setup({
		style = "night",
		transparent = true,
		on_highlights = function(hl, c)
			vim.o.cursorline = false
		end
	})
	vim.cmd.colorscheme("tokyonight")

	require('lualine').setup {
		options = {
			theme = 'tokyonight'
		}
	}
end

require("nvim-treesitter").install({
	"python",
	"lua",
	"perl",
	"bash",
	"c",
	"cpp"
})
-- highlighting
vim.api.nvim_create_autocmd('FileType', {
	pattern = { '<filetype>' },
	callback = function() vim.treesitter.start() end,
})
-- folding
vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.wo[0][0].foldmethod = 'expr'
-- identation [experimental]
vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

local kind_icons = {
  Text = "",
  Method = "󰆧",
  Function = "󰊕",
  Constructor = "",
  Field = "󰇽",
  Variable = "󰂡",
  Class = "󰠱",
  Interface = "",
  Module = "",
  Property = "󰜢",
  Unit = "",
  Value = "󰎠",
  Enum = "",
  Keyword = "󰌋",
  Snippet = "",
  Color = "󰏘",
  File = "󰈙",
  Reference = "",
  Folder = "󰉋",
  EnumMember = "",
  Constant = "󰏿",
  Struct = "",
  Event = "",
  Operator = "󰆕",
  TypeParameter = "󰅲",
}

local cmp = require("cmp")
local luasnip = require("luasnip")
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.setup({
	mapping = cmp.mapping.preset.insert({
		['<CR>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				if luasnip.expandable() then
					luasnip.expand()
				else
					cmp.confirm({
						select = true,
					})
					cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
				end
			else
				fallback()
			end
		end),

		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				if #cmp.get_entries() == 1 then
					cmp.confirm({ select = true })
				else
					cmp.select_next_item()
				end
			elseif luasnip.locally_jumpable(1) then
				luasnip.jump(1)
			else
				fallback()
			end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.locally_jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		-- ['<C-y>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	view = {
		entries = {name = 'custom', selection_order = 'near_cursor' }
	},
	snippet = {
		-- specify a snippet engine
		expand = function(args)
			require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	completion = {
		autocomplete = {
			cmp.TriggerEvent.TextChanged,
			cmp.TriggerEvent.InsertEnter
		},
		completeopt = 'menu,menuone,noinsert,noselect', -- noinsert/noselect предотвращает автоматическую вставку первого элемента
	},
	window = {
		-- config = { -- :h nvim_open_win()
		--     border = "solid",
		--     zindex = 100,
		-- },
		completion = cmp.config.window.bordered({
			border = "rounded",
		}),
		documentation = cmp.config.window.bordered({
			border = "rounded",
		}),
	},
	formatting = {
		format = function(entry, vim_item)
			-- Kind icons
			vim_item.kind = string.format(
				'%s %s',
				kind_icons[vim_item.kind],
				vim_item.kind
			)
			-- Source
			vim_item.menu = ({
				buffer = "[Buffer]",
				nvim_lsp = "[LSP]",
				luasnip = "[LuaSnip]",
				nvim_lua = "[Lua]",
				latex_symbols = "[LaTeX]",
			})[entry.source.name]
			return vim_item
		end
	},
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' }, -- For luasnip users.
	}, {
		{ name = 'buffer' },
		{ name = "path" },
	})
})

-- Mason setup
require("mason").setup({
	PATH = "append",
})

require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls", -- lua LSP
		-- "html", -- html LSP
		-- "cssls", -- css LSP
		-- "emmet_ls", -- emmet LSP
		-- "jsonls", -- json LSP
	},
	automatic_installation = false,
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- on_attach function to map keys after LSP attaches to buffer
local on_attach = function(_, bufnr)
	local opts = { noremap = true, silent = true, buffer = bufnr }
	local keymap = vim.keymap.set

	keymap("n", "gd", vim.lsp.buf.definition, opts)                                     -- go to definition
	keymap("n", "gr", vim.lsp.buf.references, opts)                                     -- go to references
	keymap("n", "gi", vim.lsp.buf.implementation, opts)                                 -- go to implementation
	keymap("n", "K", vim.lsp.buf.hover, opts)                                           -- hover
	keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)                                 -- rename
	keymap("n", "<leader>ca", vim.lsp.buf.code_action, opts)                            -- code action
	keymap("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, opts)         -- previous diagnostic
	keymap("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, opts)          -- next diagnostic
	keymap("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, opts) -- format
end

-- Lua LSP
vim.lsp.config.lua_ls = {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", "stylua.toml", ".git" },
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			diagnostics = { globals = { "vim" } }, -- recognize the `vim` global
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false, -- disable annoying warnings for third-party libraries
			},
			telemetry = { enable = false },
		},
	},
}

vim.lsp.config('pylsp', {
	settings = {
		pylsp = {
			plugins = {
				pycodestyle = {
					ignore = {
						"E101",
						"E231",
						"E226",
						"E227",
						"E251",
						"E252",
						"E261",
						"E265",
						"E302",
						"E305",
						"E501",
						"E701",
						"E704",
						"W191",
					},
					maxLineLength = 100
				}
			}
		}
	}
})

-- diagnostics config with modern sign configuration
vim.diagnostic.config({
	virtual_text = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.HINT] = "",
			[vim.diagnostic.severity.INFO] = "",
		},
	},
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})

local dap = require('dap')
local dapui = require('dapui')
require("overseer").enable_dap()
dapui.setup({})
require("neodev").setup({
	library = { plugins = { "nvim-dap-ui" }, types = true },
})
require("dap-python").setup(
	"~/.local/share/nvim/mason/packages/debugpy/venv/bin/python",
	{
		console = "externalTerminal"
	}
)
-- Не закидывать в mappings.lua потому что там он не поймет переменную dap
vim.keymap.set("n", "<F5>", function()
	dap.continue()
end, { desc = "Continue" })
-- vim.keymap.set("n", "<C-F5>", function()
--     dap.run_last()
-- end, { desc = "Run last" })
vim.keymap.set("n", "<leader>b", function()
	dap.toggle_breakpoint()
end, { desc = "Toggle breakpoint" })


-- Настройка интерфейса (автоматическое открытие/закрытие панелей как в VS Code)
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

dap.adapters.gdb = {
  type = "executable",
  command = "gdb",
  args = {
	  "-q", "--interpreter=dap",
	  "--eval-command", "set print pretty on",
	  "--eval-command", "set disassembly-flavor intel"
  }
}

-- https://codeberg.org/mfussenegger/nvim-dap/wiki/C-C---Rust-(gdb-via--vscode-cpptools)#installation
dap.configurations.c = {
  {
	name = "Launch",
	type = "gdb",
	request = "launch",
	program = function()
	  return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
	end,
	args = {}, -- provide arguments if needed
	cwd = "${workspaceFolder}",
	stopAtBeginningOfMainSubprogram = false,
  },
  {
	name = "Select and attach to process",
	type = "gdb",
	request = "attach",
	program = function()
	  return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
	end,
	pid = function()
	  local name = vim.fn.input('Executable name (filter): ')
	  return require("dap.utils").pick_process({ filter = name })
	end,
	cwd = '${workspaceFolder}'
  },
  {
	name = 'Attach to gdbserver :1234',
	type = 'gdb',
	request = 'attach',
	target = 'localhost:1234',
	program = function()
	  return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
	end,
	cwd = '${workspaceFolder}'
  }
}

dap.configurations.cpp = dap.configurations.c
dap.configurations.rust = dap.configurations.c

dap.defaults.fallback.external_terminal = {
  command = '/usr/bin/kitty',
  args = {'--hold', '-e'}, -- --hold оставляет окно открытым после завершения
}

-- :h highlight-groups
vim.fn.sign_define('DapBreakpoint', { text=' ', texthl='ErrorMsg', linehl='', numhl='' })
-- vim.fn.sign_define('DapStopped', { text='🟡', texthl='', linehl='', numhl='' })
-- vim.fn.sign_define('DapLogPoint', { text='🔵', texthl='', linehl='', numhl='' })

local newcolor = function(name, color)
	vim.api.nvim_set_hl(0, name, { fg = color })
	return name
end
require("oil").setup({ 
	-- See :help oil-columns
	columns = {
		-- { "permissions", highlight = newcolor("gray", "#888888") },
		-- { "size", highlight = newcolor("fairyellow", "#ffffaf") },
		-- { "mtime", highlight = newcolor("dark-green", "#00d787") },
		"icon",
	},
	skip_confirm_for_simple_edits = true,
	watch_for_changes = false,
	view_options = {
		show_hidden = true
	},
	constrain_cursor = "name",
	watch_for_changes = true,
	keymaps = {
		["gd"] = function()
			require("oil").set_columns({
				{ "permissions", highlight = newcolor("gray", "#888888") },
				{ "size", highlight = newcolor("fairyellow", "#ffffaf") },
				{ "mtime", highlight = newcolor("dark-green", "#00d787") },
				"icon",
			})
		end,
		["!"] = "actions.open_terminal",
		["<C-p>"] = "actions.preview",
		["<C-f>"] = "actions.preview_scroll_down",
		["<C-b>"] = "actions.preview_scroll_up",
	},
	float = {
		padding = 0,
		-- max_width = 40,
		max_height = 12,
		-- win_options = {
		--     winblend = 10,
		-- },
		border = "rounded",
		preview_split = "right",
		-- :h nvim_open_win()
		override = function(conf)
			conf.anchor = "NW"
			-- conf.relative = 'win'
			conf.row = 0
			conf.col = 0
			return conf
		end,
		win_options = {
			statusline = "",
			winbar = "",
		},
	},
	preview = {
		win_options = {
			statusline = "",
			winbar = "",
		},
	},
})
