# home.nix

# https://www.chrisportela.com/posts/home-manager-flake/
# home-configuration.nix(5)
# https://learngitbranching.js.org/

{
	pkgs,
	lib,
	...
}:
{
	imports = [
		../../modules/home/fastfetch.nix
		../../modules/home/niri-wm-related
		../../modules/home/wine.nix
		../../modules/home/nvim
	];

	home.username = "vlad";
	home.homeDirectory = lib.mkForce "/home/vlad/";    

	programs.git = {
		enable = true;
		package = pkgs.gitFull;
		settings = {
			user.name = "xPlay5r";
			# credential.helper = "storage";
		};
	};

	home.stateVersion = "26.05"; # Comment out for error with "latest" version
	programs.home-manager.enable = true;

	# Я не смог придумать хороое разделение в новый файл для списка программ
	# TODO придумать
	home.packages = with pkgs; [
# gui
kitty
steam
# mindustry
telegram-desktop
discord
zathura
# bristol
prismlauncher
hyperspeedcube
obs-studio
brave
gimp
inkscape
blender
libreoffice
pavucontrol
nwg-look # для проверки темы
dconf-editor

# для wm
gnome-tweaks
wl-clipboard brightnessctl
playerctl
wl-gammactl wooz

# cli/tui утилиты
python3
translate-shell
ddgr
lsd bat htop btop
jq
groff

# надо
# amnezia-vpn
	];
}

# vim:ts=2:
