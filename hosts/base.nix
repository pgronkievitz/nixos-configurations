{ lib, pkgs, config, ... }: {

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_zen;
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
  users.users.pg = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "libvirtd" "podman" ];
    shell = pkgs.zsh;
    description = "Patryk Gronkiewicz";
  };
  time.timeZone = "Europe/Warsaw";
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    (import (builtins.fetchGit {
      url = "https://github.com/nix-community/emacs-overlay.git";
      rev = "2ff125e11371b88b1c4edeaa6f96355fbfee96da";
    }))
  ];
}
