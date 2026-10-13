{
	inputs,
	...
}:
{
	imports = [
		inputs.nix-index-database.nixosModules.nix-index
	];
	# https://github.com/nix-community/nix-index
	# programs.command-not-found.enable = false;
	# /nix/var/nix/profiles/per-user/root/channels/nixos/programs.sqlite
	# programs.command-not-found.dbPath = "/nix/var/nix/profiles/per-user/root/channels/nixos/programs.sqlite";
	programs.nix-index.enableZshIntegration = true;
	programs.nix-index.enableBashIntegration = true;
	programs.nix-index-database.comma.enable = true;
}
# vim:ts=2:
