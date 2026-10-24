# disk-management.nix
# нестрогая декларация утилит для управления дисками

{
	pkgs,
	...
}:
{
	imports = [
		./polkit.nix
	];

	environment.systemPackages = with pkgs; [
		gparted
		ventoy-full-gtk
	];
}

# vim:ts=2:
