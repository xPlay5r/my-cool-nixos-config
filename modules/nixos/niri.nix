{
	pkgs,
	...
}:
{
	# Включить niri
	services.displayManager.ly.enable = true;
	programs.niri.enable = true;
	security.pam.services.swaylock = {};

	environment.systemPackages = with pkgs; [ xwayland-satellite ];
}
# vim:ts=2:
