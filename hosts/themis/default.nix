{ lib, config, pkgs, ... }: {
  networking = {
    hostName = "themis";
    interfaces.enp2s0.useDHCP = true;
    interfaces.wlo1.useDHCP = true;
  };
  hardware.bluetooth = {
    enable = true;
    settings = { General = { Enable = "Source,Sink,Media,Socket"; }; };
  };
}
