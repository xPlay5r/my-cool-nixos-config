{
	pkgs,
	...
}:
{
	home.packages = with pkgs; [
		wine64Packages.stableFull
	]
}

# vim:ts=2:
