{ lib, config, pkgs, ... }: {
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./backups.nix
  ];
  networking = {
    hostName = "apollo";
    interfaces.enp3s0.useDHCP = true;
    interfaces.wlp2s0.useDHCP = false;
  };
  hardware.bluetooth.enable = false;

  services.openssh.listenAddresses = [{
    addr = "100.79.65.104";
    port = 22;
  }];
}
