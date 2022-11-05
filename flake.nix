{
  description = "pgronkievitz's config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-asus.url = "github:Cogitri/nixpkgs/asusctl";
    impermanence.url = "github:nix-community/impermanence";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
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
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
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
          ./home/zathura.nix
          ./home/mpv.nix
          ./home/redshift.nix
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
                theme = import ./home/theming.nix;
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
        servers = [ ./modules/monitoring.nix ./modules/selfhosted ];
        graphics = [ ./modules/fonts.nix ];
      in {
        artemis.modules = [
          ./hosts/artemis
          ./modules/games.nix
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
            programs.kdeconnect.enable = true;
            nixpkgs.overlays = let
              overlay-asus = final: prev: {
                asus = inputs.nixpkgs-asus.legacyPackages.${prev.system};
              };
            in [ overlay-asus ];
          }
          inputs.nixos-hardware.nixosModules.asus-zephyrus-ga401
          inputs.impermanence.nixosModules.impermanence
          ./modules/development
          ./modules/development/devops.nix
          ./modules/virtual-machines.nix
          ./modules/audio.nix
          ./modules/school.nix
          ./modules/xserver.nix
          ./modules/gpt.nix
          ./modules/android.nix
          # ./modules/tuxedo.nix
          # inputs.tuxedo.nixosModule
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
          # ./modules/selfhosted/freshrss.nix
          ./modules/selfhosted/wallabag.nix
          ./modules/selfhosted/torrents.nix
          ./modules/selfhosted/readarr.nix
          ./modules/selfhosted/sonarr.nix
          ./modules/selfhosted/radarr.nix
          ./modules/selfhosted/lidarr.nix
          ./modules/selfhosted/bazarr.nix
          ./modules/selfhosted/prowlarr.nix
          ./modules/selfhosted/navidrome.nix
          ./modules/selfhosted/znc.nix
          ./modules/gpt.nix
        ] ++ servers;
        dart.modules = [
          ./hosts/dart
          ./modules/zfs.nix
          { home-manager.users.pg.imports = hmModules.dart; }
          ./modules/selfhosted/grocy.nix
          ./modules/selfhosted/calibre.nix
          ./modules/selfhosted/nextcloud.nix
          ./modules/selfhosted/photoprism.nix
          ./modules/selfhosted/openbooks.nix
          ./modules/selfhosted/minio.nix
          ./modules/selfhosted/podsync.nix
          ./modules/selfhosted/kiwix.nix
          ./modules/selfhosted/miniflux.nix
          {
            age.secrets.ncdb.file = ./secrets/ncdb.age;
            age.secrets.ncmonitoring = {
              file = ./secrets/ncmonitoring.age;
              owner = "nextcloud-exporter";
            };
            age.secrets.photos.file = ./secrets/photoprism.age;
            age.secrets.photos-db.file = ./secrets/photoprismdb.age;
            age.secrets.miniflux.file = ./secrets/miniflux.age;
            age.secrets.minifluxdb.file = ./secrets/minifluxdb.age;
          }
          ./modules/selfhosted/paperless.nix
          ./modules/gpt.nix
        ] ++ servers;
        hubble.modules = [
          ./hosts/hubble
          {
            home-manager.users.pg.imports = hmModules.hubble;
            age.secrets.giteadb.file = ./secrets/giteadb.age;
            age.secrets.matrixdb.file = ./secrets/matrixdb.age;
            age.secrets.pleroma = {
              file = ./secrets/pleroma.age;
              owner = "pleroma";
            };
          }
          ./modules/selfhosted/pihole.nix
          ./modules/selfhosted/grafana.nix
          ./modules/selfhosted/prometheus.nix
          ./modules/selfhosted/pleroma.nix
          ./modules/selfhosted/gitea.nix
          ./modules/selfhosted/lenpaste.nix
          ./modules/selfhosted/n8n.nix
          ./modules/selfhosted/websites.nix
          ./modules/selfhosted/matrix.nix
          ./modules/mbr.nix
        ] ++ servers;
      };
      deploy = {
        sshUser = "pg";
        user = "root";
        sshOpts = [ "-p" "14442" ];
        nodes = {
          # apollo = {
          #   hostname = "apollo.gronkiewicz.xyz";
          #   profiles.system = {
          #     path = deploy-rs.lib.x86_64-linux.activate.nixos
          #       self.nixosConfigurations.apollo;
          #   };
          # };
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
        };
      };
    };
}
