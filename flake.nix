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
      hmModules =
        let
          shared = [
            ./home
            ./home/bat.nix
            ./home/lorri.nix
            ./home/lsd.nix
            ./home/fzf.nix
            ./home/editors/neovim
            ./home/git.nix
          ];
          servers = [ ];
        in
        {
          ################
          # WORKSTATIONS #
          ################
          ###########
          # SERVERS #
          ###########
          dart = shared ++ servers ++ [ ];
          hubble = shared ++ servers ++ [ ];
        };

    in
    fup.lib.mkFlake {
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
      hosts =
        let
          common = [ ];
          servers = [ ./modules/monitoring.nix ./modules/selfhosted ];
        in
        {
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
            ./modules/selfhosted/vaultwarden.nix
            ./modules/selfhosted/wallabag.nix
            ./modules/selfhosted/torrents.nix
            ./modules/selfhosted/navidrome.nix
            ./modules/selfhosted/archivebox.nix
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
