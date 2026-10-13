{
	pkgs,
	...
}:
{
	# man
	documentation.enable = true;
	documentation.dev.enable = true;
	documentation.doc.enable = true;
	documentation.info.enable = true;
	documentation.man.enable = true;
	documentation.man.cache.enable = true;
	documentation.nixos.includeAllModules = true;

	environment.systemPackages = with pkgs; [ man-pages man-pages-posix ];
}

# vim:ts=2:
