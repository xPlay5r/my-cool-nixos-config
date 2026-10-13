{
	pkgs,
	...
}:
{
	environment.systemPackages = with pkgs; [ python3 ];
}

# vim:ts=2:
