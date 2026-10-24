# nixos configuration

{
	pkgs,
	lib,
	...
}:
{
	imports = [
		../../modules/nixos/keyd.nix
		../../modules/nixos/niri.nix
		../../modules/nixos/disk-management.nix
		../../modules/nixos/gnome.nix
		../../modules/nixos/unzip.nix
		../../modules/nixos/manual.nix
		../../modules/nixos/python.nix
		../../modules/nixos/throne.nix
		../../modules/nixos/firefox.nix
		../../modules/nixos/nix-index.nix
		../../modules/nixos/garbage_collect.nix
	];
	# Define a user account. Don't forget to set a password with ‘passwd’.
	users.users."vlad" = {
		isNormalUser = true;
		description = "Владислав";
		extraGroups = [ "networkmanager" "wheel" "input" ];
	};

	nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
		"steam" "steam-unwrapped" "discord" "discord-unwrapped" "vista-fonts"
		"ventoy-gtk3"
	];

	nixpkgs.config.permittedInsecurePackages = [
		"ventoy-gtk3-1.1.18"
	];
}

# vim:ts=2:
