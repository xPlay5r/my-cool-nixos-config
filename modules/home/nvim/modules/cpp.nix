{
	pkgs,
	...
}:
{
	home.packages = with pkgs; [
		clang-tools
	];

	programs.neovim = {
		coc.enable = true;

		coc.settings = {
			languageserver = {
				clangd = {
					command = "${pkgs.clang-tools}/bin/clangd";
					rootPatterns = [ "compile_flags.txt" "compile_commands.json" ];
					filetypes = [ "c" "cc" "cpp" "c++" "objc" "objcpp" ];
				};
			};
		};

		coc.pluginConfig = ''
			let g:coc_global_extensions = ['coc-clangd']
		'';
	};
}
# vim:ts=2:
