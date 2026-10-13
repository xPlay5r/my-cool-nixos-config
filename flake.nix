# flake.nix

# smb's config: https://github.com/wochap/nix-config
# flake structure ref: https://nixos-and-flakes.thiscute.world/other-usage-of-flakes/outputs
# cool kickstart: https://github.com/ryan4yin/nix-config/blob/i3-kickstarter/flake.nix

# note: рассмотреть ed, rlwrap (https://www.reddit.com/r/linux/comments/dbu99e/does_anyone_use_ed_regularly_what_for/)

{
	description = "A very basic flake";

	inputs = {
		flake-parts = {
			url = "github:hercules-ci/flake-parts";
		};
		nixpkgs = {
			url = "github:nixos/nixpkgs?ref=nixos-unstable";
		};
		nix-index-database = {
			url = "github:nix-community/nix-index-database";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = inputs @ {
		self,
		nixpkgs,
		flake-parts,
		home-manager,
		...
	}:
		flake-parts.lib.mkFlake { inherit inputs; } {
			systems = [
				"x86_64-linux"
				# "aarch64-linux"
				# "aarch64-darwin"
				# "x86_64-darwin"
			];
			# https://flake.parts/define-custom-flake-attribute#when-should-i-declare-a-custom-flake-output
			# tldr: я могу декларировать все во flake={} потому, что это МОЙ конфиг. И необязательно perSystem
			# но потом надо по особенному брать готовые опции
			flake = {
				nixosConfigurations.nixos = let
					user = "vlad";
					specialArgs = { username = user; };
				in nixpkgs.lib.nixosSystem {
					specialArgs = { inherit inputs; };
					modules = [
						./hosts/nixos
						./users/${user}/nixos.nix

						home-manager.nixosModules.home-manager
						{
							home-manager.useGlobalPkgs = true;
							home-manager.useUserPackages = true;

							home-manager.extraSpecialArgs = inputs // specialArgs;
							home-manager.users.${user} = import ./users/${user}/home.nix;
						}
					];
				};
			};
		};
}

# vim:ts=2:
