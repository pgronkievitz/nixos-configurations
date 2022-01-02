{ ... }: {
  imports = [ ./hardware-configuration.nix ./backups.nix ];
  networking = {
    hostName = "dart";
    domain = "gronkiewicz.xyz";
    hostId = "39a39d05";
  };
  hardware.bluetooth.enable = false;
  services.openssh.listenAddresses = [{
    addr = "100.95.47.112";
    port = 14442;
  }];
}
