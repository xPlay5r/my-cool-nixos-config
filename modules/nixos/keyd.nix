{
	pkgs,
	...
}:
{
	services.keyd.enable = true;
	services.keyd.keyboards.default.settings.main = {
		capslock = "overload(control, esc)";
		rightshift = "overload(shift, capslock)";
	};

	environment.systemPackages = with pkgs; [ keyd ];
}
# vim:ts=2:
