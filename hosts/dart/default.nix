{ ... }:
{
  imports = [ ./hardware-configuration.nix ./backups.nix ];
  networking = {
    hostName = "dart";
  };
  hardware.bluetooth.enable = false;
}
