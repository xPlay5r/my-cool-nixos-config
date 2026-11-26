{
	pkgs,
	...
}:
{
	programs.swaylock.enable = true;
	programs.swaylock.package = pkgs.swaylock-effects;

	services.swayidle.enable = true;
}

# vim:ts=2:
