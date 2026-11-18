{
	pkgs,
	...
}:
{
	home.packages = with pkgs; [
		imv
	];
}

# vim:ts=2:
