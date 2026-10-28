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
}
# vim:ts=2:
