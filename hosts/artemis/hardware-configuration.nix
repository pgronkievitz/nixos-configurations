# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "usbhid" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "tmpfs";
    fsType = "tmpfs";
  };

  fileSystems."/nix" = {
    device = "data/root/nix";
    fsType = "zfs";
  };

  fileSystems."/nix/store" = {
    device = "/nix/store";
    fsType = "none";
    options = [ "bind" ];
  };

  fileSystems."/home" = {
    device = "data/root/home";
    fsType = "zfs";
  };

  fileSystems."/persistent" = {
    device = "data/root/persistent";
    fsType = "zfs";
    neededForBoot = true;
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/60A2-56B8";
    fsType = "vfat";
  };

  environment.persistence."/persistent" = {
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/blueman"
      "/var/lib/systemd/coredump"
      "/var/lib/tailscale"
      "/var/lib/docker"
      "/var/lib/asusd"
      "/etc/NetworkManager/system-connections"
      "/etc/ssh"
    ];
    files = [ "/etc/machine-id" "/etc/supergfxd.conf" ];
  };

  swapDevices = [ ];

  # high-resolution display
  hardware.video.hidpi.enable = lib.mkDefault true;
}
