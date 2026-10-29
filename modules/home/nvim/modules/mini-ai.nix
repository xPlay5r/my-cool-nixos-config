{
	pkgs,
	...
}:
{
	programs.neovim.plugins = [
		pkgs.vimPlugins.mini-extra
		{
			plugin = pkgs.vimPlugins.mini-ai;
			type = "lua";
			# nix string interpolation так раздражает
			config = /* lua */ ''
				local MiniAi = require("mini.ai")
				local spec = require('mini.extra').gen_ai_spec
				MiniAi.setup({
					custom_textobjects = {
						-- python f-string or bash $'...'
						Q = function()
							ft = vim.o.ft
							if ft == "python" then
								return { { 'f%b""', "f%b'''" }, '^f.().*().$' }
							elseif ft == "bash" then
								return { { '%$%b""', "%$%b'''" }, '^..().*().$' }
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
						A = spec.buffer(),
						D = spec.diagnostic(),
						N = spec.number(),
						L = spec.line(),
					}
				})
			'';
		}
	];
}
# vim:ts=2:
