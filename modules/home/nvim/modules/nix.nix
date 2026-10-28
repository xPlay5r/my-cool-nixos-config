{
	pkgs,
	...
}:
{
	home.packages = with pkgs; [
		nixd
	];

	programs.neovim = {
		coc.enable = true;

		coc.settings = {
			languageserver = {
				nixd = {
					command = "${pkgs.nixd}/bin/nixd";
					rootPatterns = [ "./nixd.json" ];
					filetypes = [ "nix" ];
				};
			};
		};
		#
		# coc.pluginConfig = ''
		# 	let g:coc_global_extensions = ['nixd']
		# '';
	};
}
# vim:ts=2:
