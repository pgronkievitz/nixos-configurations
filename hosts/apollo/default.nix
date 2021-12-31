{ ... }: {
  imports = [ ./hardware-configuration.nix ./backups.nix ];
  networking = {
    hostName = "apollo";
    domain = "gronkiewicz.xyz";
    interfaces.enp3s0.useDHCP = true;
    interfaces.wlp2s0.useDHCP = false;
  };
  hardware.bluetooth.enable = false;
}
