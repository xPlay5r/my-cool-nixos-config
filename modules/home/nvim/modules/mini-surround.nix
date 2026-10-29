{
	pkgs,
	...
}:
{
	programs.neovim.plugins = [
		{
			plugin = pkgs.vimPlugins.mini-surround;
			type = "lua";
			config = ''
				require("mini.surround").setup({
					mappings = {
						add = 'ys', -- Add surrounding in Normal and Visual modes
						delete = 'ds', -- Delete surrounding
						find = "", -- Find surrounding (to the right)
						find_left = "", -- Find surrounding (to the left)
						highlight = "", -- Highlight surrounding
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
						-- python f-string or bash $""
						Q = {
							input = function()
								local ft = vim.o.ft
								if ft == "python" then
									return { { [[f%b""]], [[f%b""]] }, '^f.().*().$' }
								elseif ft == "bash" then
									return { { [[%$%b""]], [[%$%b""]] }, '^..().*().$' }
								end
							end,
							output = function()
								local ft = vim.o.ft
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
							output = { left = [[''${]], right = '}' }
						},
						-- equals ___ = smth
						e = {
							input = { '^.*=.*$', '^%s*().-()%s*=%s*.-$' },
							output = function()
								local eq_key = vim.pesc(vim.fn.input("Variable name: "))
								local ft = vim.o.ft -- filetype
								if ft == "bash" or ft == "sh" then
									local eq_txt = "="
								else
									local eq_txt = " = "
								end
								return { left = eq_key .. eq_txt, right = "" }
							end
						},
						-- equals smth = ___
						E = {
							input = { '^.*=.*$', '^%s*.-%s*=%s*().-()$' },
							output = function()
								local eq_val = vim.pesc(vim.fn.input("Value of variable: "))
								local ft = vim.o.ft -- filetype
								if ft == "bash" or ft == "sh" then
									local eq_txt = "="
								else
									local eq_txt = " = "
								end
								return { left = "", right = eq_txt .. eq_val }
							end
						}
					},
					search_method = 'cover_or_next'
				})

				-- Remap adding surrounding to Visual mode selection
				vim.keymap.del('x', 'ys')
				vim.keymap.set('x', 'S', [[:<C-u>lua MiniSurround.add('visual')<CR>]], { silent = true })

				-- Make special mapping for "add surrounding for line"
				vim.keymap.set('n', 'yss', 'ys_', { remap = true })

				vim.keymap.set('n', 'yS', 'ys$', { remap = true })
			'';
		}
	];
}
# vim:ts=2:
