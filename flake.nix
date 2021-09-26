{
  description = "pgronkievitz's config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, nixos-hardware, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          allowBroken = true;
        };
      };
      lib = nixpkgs.lib;
    in {

      homeManagerConfigurations = {
        pg = home-manager.lib.homeManagerConfiguration {
          inherit system pkgs;
          username = "pg";
          homeDirectory = "/home/pg";
          configuration = { imports = [ ./users/pg/home.nix ]; };
        };
      };

      packages."${system}" = pkgs;
      nixosConfigurations = {
        artemis = lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/base.nix
            ./hosts/artemis/default.nix
            nixos-hardware.nixosModules.system76
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.pg = import ./users/pg/home.nix;
            }
            ./modules/dev.nix
            ./modules/games.nix
            ./modules/misc.nix
            ./modules/office.nix
            ./modules/python.nix
          ];
        };
        apollo = lib.nixosSystem {
          inherit system;
          modules = [ ./hosts/base.nix ]; # ./hosts/apollo/base.nix ];
        };
      };

    };
}
