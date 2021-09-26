{ lib, pkgs, config, ... }: {

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
  networking = {
    networkmanager.enable = true;
    useDHCP = false;
    firewall = {
      enable = true;
      trustedInterfaces = [ "tailscale0" ];
    };
  };
  security.auditd.enable = true;
  security.audit.enable = true;
  security.audit.rules = [ "-a exit,always -F arch=b64 -S execve" ];
  security.sudo.execWheelOnly = true;
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "pl";
  };
  virtualisation.libvirtd = {
    enable = true;
    qemuPackage = pkgs.qemu_kvm;
    qemuOvmf = true;
    onBoot = "ignore";
    onShutdown = "shutdown";
  };
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    dockerSocket.enable = true;
  };
  nix.trustedUsers = [ "root" "pg" ];
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    neovim
    zsh
    cachix
    networkmanager
    networkmanagerapplet
    tailscale
    OVMF
    OVMF-CSM
    OVMF-secureBoot
  ];
  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
  services.tailscale.enable = true;
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = false;
  };
  programs.ssh.startAgent = true;
  services.openssh = {
    enable = true;
    allowSFTP = false;
    passwordAuthentication = false;
    permitRootLogin = "no";
    listenAddresses = [{
      addr = "100.79.65.104";
      port = 22;
    }];
  };
  users.mutableUsers = false;
  users.users.pg = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "libvirtd" "podman" ];
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
  time.timeZone = "Europe/Warsaw";
  nixpkgs.config.allowUnfree = true;
  nix = {
    autoOptimiseStore = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "-d --delete-older-than '30d'";
    };
  };
  nixpkgs.overlays = [
    (import (builtins.fetchGit {
      url = "https://github.com/nix-community/emacs-overlay.git";
      rev = "2ff125e11371b88b1c4edeaa6f96355fbfee96da";
    }))
  ];
}
