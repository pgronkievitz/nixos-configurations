{
  description = "pgronkievitz's config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    emacs-overlay.url = "github:nix-community/emacs-overlay/master";
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }:
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
            ./modules/boot.nix
            ./modules/locale.nix
            ./modules/nix.nix
            ./modules/security.nix
            ./modules/virt.nix
            ./modules/cache.nix
            ./modules/kube.nix
            ./modules/containers.nix
            ({ nixpkgs.overlays = [ inputs.emacs-overlay.overlay ]; })
          ];
        };
        apollo = lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/base.nix
            ./hosts/apollo/default.nix
            # ./modules/kubeserver.nix
            ./modules/security.nix
            ./modules/boot.nix
            ./modules/nix.nix
            ./modules/containers.nix
            ./modules/monitoring.nix
            # ./modules/selfhosted/nginx.nix
            # ./modules/selfhosted/bibliogram.nix
            # ./modules/selfhosted/freshrss.nix
            # ./modules/selfhosted/nextcloud.nix
            # ./modules/selfhosted/vaultwarden.nix
            # ./modules/selfhosted/wallabag.nix
            ({ nixpkgs.overlays = [ inputs.emacs-overlay.overlay ]; })
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.pg = import ./users/pg/home.nix;
            }
          ];
        };
        themis = lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/base.nix
            ./hosts/themis/default.nix
            ./modules/dev.nix
            ./modules/misc.nix
            ./modules/office.nix
            ./modules/kube.nix
            ./modules/locale.nix
            ./modules/nix.nix
            ./modules/security.nix
            ./modules/virt.nix
            ./modules/cache.nix
            ./modules/boot.nix
            ./modules/containers.nix
            ({ nixpkgs.overlays = [ inputs.emacs-overlay.overlay ]; })
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.pg = import ./users/pg/home.nix;
            }
          ];
        };
      };

    };
}
