{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "usb_storage"
    "usbhid"
    "uas"
    "sd_mod"
    "rtsx_pci_sdmmc"
  ];
  boot.kernelModules = [ "kvm-intel" ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/723d1af3-981b-4557-bce1-c3d39874d899";
    fsType = "btrfs";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/0CDD-BC72";
    fsType = "vfat";
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/a6f5008f-788a-4043-ad35-f04f90026018";
    fsType = "btrfs";
  };

  # fileSystems."/media/seagate" = {
  #   device = "/dev/disk/by-uuid/a6f5008f-788a-4043-ad35-f04f90026018";
  #   fsType = "btrfs";
  # };
  # fileSystems."/media/backup" = {
  #   device = "/dev/disk/by-uuid/a6f5008f-788a-4043-ad35-f04f90026018";
  #   fsType = "btrfs";
  # };

  swapDevices = [ ];

}
