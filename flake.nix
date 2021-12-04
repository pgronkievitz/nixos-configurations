{
  description = "pgronkievitz's config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    emacs-overlay.url = "github:nix-community/emacs-overlay/master";
    fu.url = "github:numtide/flake-utils/master";
    fup = {
      url = "github:gytis-ivaskevicius/flake-utils-plus/master";
      inputs.flake-utils.follows = "fu";
    };
    # kmonad = {
    #   url = "github:kmonad/kmonad/master";
    #   inputs.nixpkgs.follows = "nixpkgs";
    #   inputs.flake-utils.follows = "fup";
    # };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, fup, ... }:
    let
      hmModules = let
        shared = [
          ./home
          ./home/bat.nix
          ./home/lorri.nix
          ./home/lsd.nix
          ./home/fzf.nix
          ./home/editors/neovim
          ./home/git.nix
        ];
        graphics = [
          ./home/xserver.nix
          ./home/editors/emacs
          ./home/alacrity.nix
          ./home/dunst.nix
          ./home/zathura.nix
          ./home/syncthing.nix
          ./home/mpv.nix
          ./home/redshift.nix
          ./home/rofi.nix
          ./home/communicators.nix
          ./home/office.nix
          ./home/nmapplet.nix
          ./home/blueman.nix
        ];
      in {
        ################
        # WORKSTATIONS #
        ################
        artemis = shared ++ graphics
          ++ [ ./home/private ./home/games.nix ./home/graphics.nix ];
        themis = shared ++ graphics ++ [ ./home/work ];
        ###########
        # SERVERS #
        ###########
        apollo = shared ++ [ ];
        dart = shared ++ [ ];
      };
    in fup.lib.mkFlake {
      inherit self inputs;
      hostDefaults = {
        system = "x86_64-linux";
        modules = [
          ./modules/minimal.nix
          ./modules/security.nix
          ./modules/containers.nix
          ./modules/development/kube.nix
          ./modules/development/go.nix
          ./modules/fonts.nix
          # inputs.kmonad.nixosModule
          inputs.home-manager.nixosModule
          {
            home-manager = {
              extraSpecialArgs = {
                inherit inputs self;
                colors = import ./home/colors.nix;
              };
              useGlobalPkgs = true;
              useUserPackages = true;
            };
          }
        ];
      };
      channels.nixpkgs.overlaysBuilder = channels: [
        inputs.fup.overlay
        inputs.emacs-overlay.overlay
      ];
      channelsConfig = {
        allowUnfree = true;
        allowBroken = true;
      };
      hosts = {
        artemis.modules = [
          ./hosts/artemis
          { home-manager.users.pg.imports = hmModules.artemis; }
          ./modules/development
          ./modules/virtual-machines.nix
          ./modules/audio.nix
          ./modules/school.nix
          ./modules/xserver.nix
        ];
        themis.modules = [
          ./hosts/themis
          { home-manager.users.pg.imports = hmModules.themis; }
          ./modules/development
          ./modules/development/devops.nix
          ./modules/virtual-machines.nix
          ./modules/audio.nix
          ./modules/xserver.nix
        ];
        apollo.modules = [
          ./hosts/apollo
          { home-manager.users.pg.imports = hmModules.apollo; }
          ./modules/monitoring.nix
          ./modules/selfhosted
          ./modules/selfhosted/vaultwarden.nix
          ./modules/selfhosted/nextcloud.nix
          # ./modules/selfhosted/bibliogram.nix
          # ./modules/selfhosted/kubeserver.nix
        ];
        dart.modules = [
          ./hosts/dart
          { home-manager.users.pg.imports = hmModules.dart; }
          ./modules/monitoring.nix
          ./modules/selfhosted/gitea.nix
          ./modules/selfhosted
          # ./modules/selfhosted/kubeserver.nix
        ];
      };
    };
}
