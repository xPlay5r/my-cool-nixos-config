# flake.nix

# https://github.com/wochap/nix-config

{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: let
    user = "vlad";
    host = "nixos";
    system = "x86_64-linux";
  in {
    # Please replace my-nixos with your hostname
    nixosConfigurations.${host} = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix

        home-manager.nixosModules.home-manager
        { home-manager.users.${user}.imports = [ ./home.nix ]; }
      ];
    };
    homeConfigurations.${user} = home-manager.lib.homeManagerConfiguration {
      # System is very important!
      pkgs = import nixpkgs { inherit system; };

      modules = [ ./home.nix ]; # Defined later
    };
  };
}

# vim:sw=2:
