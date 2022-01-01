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
    deploy-rs.url = "github:serokell/deploy-rs";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, fup, agenix, deploy-rs, ... }:
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
          ./home/flameshot.nix
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
        hubble = shared ++ servers ++ [ ];
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
      hosts = let
        common = [ ];
        servers = [
          { age.secrets.cloudflare.file = ./secrets/cloudflare.age; }
          ./modules/monitoring.nix
          ./modules/selfhosted
        ];
      in {
        artemis.modules = [
          ./hosts/artemis
          {
            home-manager.users.pg.imports = hmModules.artemis;
            age.secrets.artemisbkp = {
              owner = "1000";
              file = ./secrets/artemis/bkp.age;
            };
            age.secrets.artemisbkp-env = {
              owner = "1000";
              file = ./secrets/artemis/bkp-env.age;
            };
          }
          ./modules/development
          ./modules/virtual-machines.nix
          ./modules/audio.nix
          ./modules/school.nix
          ./modules/xserver.nix
          ./modules/gpt.nix
        ];
        themis.modules = [
          ./hosts/themis
          { home-manager.users.pg.imports = hmModules.themis; }
          ./modules/development
          ./modules/development/devops.nix
          ./modules/virtual-machines.nix
          ./modules/audio.nix
          ./modules/xserver.nix
          ./modules/gpt.nix
        ];
        apollo.modules = [
          ./hosts/apollo
          { home-manager.users.pg.imports = hmModules.apollo; }
          ./modules/selfhosted/vaultwarden.nix
          ./modules/selfhosted/nextcloud.nix
          ./modules/selfhosted/freshrss.nix
          ./modules/selfhosted/wallabag.nix
          ./modules/selfhosted/torrents.nix
          # ./modules/selfhosted/kubeserver.nix
          ./modules/gpt.nix
        ] ++ servers;
        dart.modules = [
          ./hosts/dart
          ./modules/zfs.nix
          { home-manager.users.pg.imports = hmModules.dart; }
          ./modules/selfhosted/gitea.nix
          ./modules/selfhosted/readarr.nix
          ./modules/selfhosted/sonarr.nix
          ./modules/selfhosted/radarr.nix
          ./modules/selfhosted/lidarr.nix
          ./modules/selfhosted/bazarr.nix
          ./modules/selfhosted/prowlarr.nix
          ./modules/selfhosted/grocy.nix
          ./modules/selfhosted/calibre.nix
          ./modules/selfhosted/restic-server.nix
          ./modules/selfhosted/paperless.nix
          # ./modules/selfhosted/kubeserver.nix
          ./modules/gpt.nix
        ] ++ servers;
        hubble.modules = [
          ./hosts/hubble
          {
            home-manager.users.pg.imports = hmModules.hubble;
          }
          # ./modules/selfhosted/kubeserver.nix
          ./modules/mbr.nix
        ] ++ servers;

      };
      deploy = {
        sshUser = "pg";
        user = "root";
        nodes = {
          apollo = {
            hostname = "apollo.gronkiewicz.xyz";
            profiles.system = {
              path = deploy-rs.lib.x86_64-linux.activate.nixos
                self.nixosConfigurations.apollo;
            };
          };
          dart = {
            hostname = "dart.gronkiewicz.xyz";
            profiles.system = {
              path = deploy-rs.lib.x86_64-linux.activate.nixos
                self.nixosConfigurations.dart;
            };
          };
          hubble = {
            hostname = "hubble.gronkiewicz.xyz";
            profiles.system = {
              path = deploy-rs.lib.x86_64-linux.activate.nixos
                self.nixosConfigurations.hubble;
            };
          };
          artemis = {
            hostname = "localhost";
            profiles.system = {
              path = deploy-rs.lib.x86_64-linux.activate.nixos
                self.nixosConfigurations.artemis;
            };
          };
        };
      };
    };
}
