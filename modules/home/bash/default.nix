{
	config,
	pkgs,
	...
}: let
	ln = path:
		config.lib.file.mkOutOfStoreSymlink ("${config.home.homeDirectory}/nix/dotfiles/" + path);
in {
	# ln ~/.bashrc ~/nix/dotfiles/.bashrc
	home.file.".bashrc".source = ln ".bashrc";
	home.file.".inputrc".source = ln ".inputrc";

	# cli/tui
	home.packages = with pkgs; [
		python3
		translate-shell
		ddgr
		lsd bat htop btop
		jq
		groff
	];
}
# vim:ts=2:
