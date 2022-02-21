{
  description = "pgronkievitz's config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    tuxedo.url = "github:blitz/tuxedo-nixos";
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
    deploy-rs.url = "github:serokell/deploy-rs";
    nixpkgs-f2k = {
      url = "github:fortuneteller2k/nixpkgs-f2k";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
          # ./home/dunst.nix
          ./home/zathura.nix
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
        inputs.nixpkgs-f2k.overlay
      ];
      channelsConfig = {
        allowUnfree = true;
        allowBroken = true;
      };
      hosts = let
        common = [ ];
        servers = [ ./modules/monitoring.nix ./modules/selfhosted ];
        graphics = [ ./modules/fonts.nix ];
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
          ./modules/development/devops.nix
          ./modules/virtual-machines.nix
          ./modules/audio.nix
          ./modules/school.nix
          ./modules/xserver.nix
          ./modules/gpt.nix
          ./modules/android.nix
          # ./modules/tuxedo.nix
          inputs.tuxedo.nixosModule
        ] ++ graphics;
        themis.modules = graphics ++ [
          ./hosts/themis
          { home-manager.users.pg.imports = hmModules.themis; }
          ./modules/development
          ./modules/development/devops.nix
          ./modules/development/kotlin.nix
          ./modules/virtual-machines.nix
          ./modules/audio.nix
          ./modules/xserver.nix
          ./modules/gpt.nix
        ];
        apollo.modules = [
          ./hosts/apollo
          { home-manager.users.pg.imports = hmModules.apollo; }
          ./modules/selfhosted/vaultwarden.nix
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
          ./modules/selfhosted/ca.nix
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
          ./modules/selfhosted/nextcloud.nix
          {
            age.secrets.ncdb.file = ./secrets/ncdb.age;
            age.secrets.ncmonitoring = {
              file = ./secrets/ncmonitoring.age;
              owner = "nextcloud-exporter";
            };
          }
          ./modules/selfhosted/paperless.nix
          # ./modules/selfhosted/kubeserver.nix
          ./modules/gpt.nix
        ] ++ servers;
        hubble.modules = [
          ./hosts/hubble
          { home-manager.users.pg.imports = hmModules.hubble; }
          ./modules/selfhosted/pihole.nix
          ./modules/selfhosted/homer.nix
          ./modules/selfhosted/grafana.nix
          ./modules/selfhosted/kuma.nix
          ./modules/selfhosted/prometheus.nix
          # ./modules/selfhosted/kubeserver.nix
          ./modules/mbr.nix
        ] ++ servers;

      };
      deploy = {
        sshUser = "pg";
        user = "root";
        sshOpts = [ "-p" "14442" ];
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
