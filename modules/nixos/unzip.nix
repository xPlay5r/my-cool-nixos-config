{
	pkgs,
	...
}:
{
	environment.systemPackages = with pkgs; [ unzip ];
}

# vim:ts=2:
