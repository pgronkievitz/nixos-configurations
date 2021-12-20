{ pkgs, ... }: {
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
    kernel.sysctl = { "net.ipv4.ip_forward" = 1; };
  };
  environment.systemPackages = [
    pkgs.htop
    pkgs.neovim
    pkgs.cachix
    pkgs.networkmanager
    pkgs.networkmanagerapplet
    pkgs.networkmanager_openvpn
    pkgs.tailscale
  ];
  services.tailscale.enable = true;
  programs.mtr.enable = true;
  users.mutableUsers = false;
  users.users.pg = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "libvirtd" "podman" "network" ];
    shell = pkgs.zsh;
    description = "Patryk Gronkiewicz";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJQfo481KqK1LXCwZdz6sDvEbgxoL0cqV3n0J+nbTjaZ u0_a313@localhost"
      "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIDH7219zlzbwGZxSHkbKWFZ6HlgYF352/88uyhapeMNRAAAABHNzaDo= pg@artemis"
      "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIAVmIuEGVOre3GqyZydZiZ/BKYFLSLqU9qZLmIn6BN1ZAAAABHNzaDo= pg@artemis"
    ];
    hashedPassword =
      "$6$spoDBwr2hANMIaZ$joTTa3EpgdT2U.eOisBOEr26WasNdiVj39J3f4DcRkG48ubiobsdIiskgdreGl2EiW4JbpKFcwp5ByjjkfgmJ/";
  };
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "pl";
  };
  time.timeZone = "Europe/Warsaw";
  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    autoOptimiseStore = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "-d --delete-older-than '30d'";
    };
    binaryCaches =
      [ "https://cache.nixos.org" "https://nix-community.cachix.org" ];
    binaryCachePublicKeys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
  programs.dconf.enable = true;
  services.kmonad = {
    enable = true;
    configfiles = [ ./sculpt.kbd ];
  };
}
