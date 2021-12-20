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
    agenix.url = "github:ryantm/agenix";
    kmonad = {
      url = "github:kmonad/kmonad/master?dir=nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "fup";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, fup, agenix, ... }:
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
        servers = [ ];
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
        ###########
        apollo = shared ++ servers ++ [ ];
        dart = shared ++ servers ++ [ ];
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
          inputs.kmonad.nixosModule
          agenix.nixosModules.age
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
          {
            home-manager.users.pg.imports = hmModules.artemis;
            age.secrets.artemisbkp.file = ./secrets/artemis/bkp.age;
            age.secrets.artemisbkp-rclone.file =
              ./secrets/artemis/bkp-rclone.age;
          }
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
          { age.secrets.cloudflare.file = ./secrets/cloudflare.age; }
          ./modules/monitoring.nix
          ./modules/selfhosted
          ./modules/selfhosted/vaultwarden.nix
          ./modules/selfhosted/nextcloud.nix
          ./modules/selfhosted/freshrss.nix
          ./modules/selfhosted/wallabag.nix
          ./modules/selfhosted/torrents.nix
          # ./modules/selfhosted/kubeserver.nix
        ];
        dart.modules = [
          ./hosts/dart
          ./modules/zfs.nix
          { home-manager.users.pg.imports = hmModules.dart; }
          { age.secrets.cloudflare.file = ./secrets/cloudflare.age; }
          ./modules/monitoring.nix
          ./modules/selfhosted/gitea.nix
          ./modules/selfhosted
          ./modules/selfhosted/readarr.nix
          ./modules/selfhosted/sonarr.nix
          ./modules/selfhosted/radarr.nix
          ./modules/selfhosted/lidarr.nix
          ./modules/selfhosted/bazarr.nix
          ./modules/selfhosted/prowlarr.nix
          ./modules/selfhosted/grocy.nix
          ./modules/selfhosted/calibre.nix
          # ./modules/selfhosted/kubeserver.nix
        ];
      };
    };
}
