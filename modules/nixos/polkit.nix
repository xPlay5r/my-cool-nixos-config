{
	pkgs,
	...
}:
{
	security.polkit.enable = true;
	security.polkit.enablePkexecWrapper = true;

	environment.systemPackages = with pkgs; [
		polkit_gnome
	];
}
# vim:ts=2:
