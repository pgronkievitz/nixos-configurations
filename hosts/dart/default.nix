{ ... }: {
  imports = [ ./hardware-configuration.nix ./backups.nix ];
  networking = {
    hostName = "dart";
    domain = "gronkiewicz.xyz";
    hostId = "39a39d05";
  };
  hardware.bluetooth.enable = false;
  services.openssh.listenAddresses = [{
    addr = "0.0.0.0";
    port = 14442;
  }];
}
