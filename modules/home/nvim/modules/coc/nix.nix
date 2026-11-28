{
	pkgs,
	...
}:
{
	home.packages = with pkgs; [
		nixd
	];

	programs.neovim.coc.settings.languageserver.nixd = {
		command = "${pkgs.nixd}/bin/nixd";
		rootPatterns = [ "./nixd.json" ];
		filetypes = [ "nix" ];
	};
}
# vim:ts=2:
