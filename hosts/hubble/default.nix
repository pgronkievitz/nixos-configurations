{ lib, ... }: {
  imports = [ ./hardware-configuration.nix ./backups.nix ];
  networking = {
    nameservers = [ "5.2.74.19" "9.9.9.9" ];
    networkmanager.insertNameservers = [ "5.2.74.19" "9.9.9.9" ];
    hostName = "hubble";
    domain = "gronkiewicz.xyz";
    hostId = "9c527ac2";
    interfaces.ens3 = {
      useDHCP = false;
      ipv4.addresses = [{
        address = "5.2.74.19";
        prefixLength = 24;
      }];
      ipv6.addresses = [{
        address = "2a04:52c0:101:ad1::";
        prefixLength = 48;
      }];
    };
    defaultGateway = {
      address = "5.2.74.1";
      interface = "ens3";
    };
    defaultGateway6 = {
      address = "2a04:52c0:101:ad1::1";
      interface = "ens3";
    };
  };
  services.openssh.listenAddresses = [{
    addr = "0.0.0.0";
    port = 14442;
  }];
  services.prometheus.exporters.smartctl.enable = lib.mkForce false;
}
