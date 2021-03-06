{ modulesPath, ... }: {
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules =
    [ "ahci" "xhci_pci" "usb_storage" "usbhid" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/03959d16-4c6d-4f07-9019-f53ccd117a30";
    fsType = "btrfs";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/D459-986D";
    fsType = "vfat";
  };

  fileSystems."/media/sdcard" = {
    device = "/dev/disk/by-uuid/761f001a-0e77-4312-a0e6-1259b788556f";
    fsType = "ext4";
  };
  fileSystems."/media/data" = {
    device = "/dev/disk/by-uuid/d5a00ce3-4675-4e19-a1b3-1d3f81218e1e";
    fsType = "btrfs";
  };
  fileSystems."/media/backup" = {
    device = "/dev/disk/by-uuid/e3390765-b53c-44c0-9094-542227e1663b";
    fsType = "btrfs";
  };

  swapDevices = [ ];

}
