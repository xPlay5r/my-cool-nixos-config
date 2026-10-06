# flake.nix

# smb's config: https://github.com/wochap/nix-config
# flake structure ref: https://nixos-and-flakes.thiscute.world/other-usage-of-flakes/outputs

# note: рассмотреть ed, rlwrap (https://www.reddit.com/r/linux/comments/dbu99e/does_anyone_use_ed_regularly_what_for/)

{
	description = "A very basic flake";

	inputs = {
		flake-parts.url = "github:hercules-ci/flake-parts";
		nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
		nix-index-database.url = "github:nix-community/nix-index-database";
		nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
		home-manager.url = "github:nix-community/home-manager";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";
	};

	# { self, flake-parts, nixpkgs, home-manager, ... }
	outputs = inputs@{ nixpkgs, flake-parts, home-manager, ... }: inputs.flake-parts.lib.mkFlake { inherit inputs; } {
		flake = {
			nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
				specialArgs = { inherit inputs; };
				modules = [
					./configuration.nix
					./garbage_collect.nix

					home-manager.nixosModules.home-manager
					{ home-manager.users.vlad.imports = [ ./home.nix ]; }
				];
			};
			homeConfigurations.vlad = home-manager.lib.homeManagerConfiguration {
				modules = [ ./home.nix ];
			};
		};
		systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];
	};
}

# vim:ts=2:
