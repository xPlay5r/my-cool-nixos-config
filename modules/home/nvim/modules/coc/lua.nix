{
	pkgs,
	...
}:
{
	home.packages = with pkgs; [
		lua-language-server
	];

	programs.neovim.coc.settings.languageserver.lua = {
		command = "${pkgs.lua-language-server}/bin/lua-language-server";
		filetypes = [ "lua" ];
	};
}
# vim:ts=2:
