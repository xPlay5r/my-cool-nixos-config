{
	pkgs,
	...
}:
{
	# https://wiki.nixos.org/wiki/Waydroid
	virtualisation.waydroid.enable = true;
	virtualisation.waydroid.package = pkgs.waydroid-nftables;

	environment.systemPackages = with pkgs; [
		wl-clipboard
	];

	# waydroid helper
	# environment.systemPackages = with pkgs; [waydroid-helper];
}
# vim:ts=2:
