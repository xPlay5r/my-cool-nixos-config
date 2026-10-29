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
		waydroid-helper
	];

	# waydroid helper
	systemd = {
		packages = with pkgs; [ waydroid-helper ];
		services.waydroid-mount.wantedBy = [ "multi-user.target" ];
	};
}
# vim:ts=2:
