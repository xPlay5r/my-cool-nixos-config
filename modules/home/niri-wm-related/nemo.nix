{
	pkgs,
	...
}:
{
	home.packages = with pkgs; [
		nemo-with-extensions
	];
}
# vim:ts=2:
