{ ... }: {
  imports = [ ./hardware-configuration.nix ./backups.nix ];
  networking = {
    hostName = "dart";
    hostId = "39a39d05";
  };
  hardware.bluetooth.enable = false;
}
