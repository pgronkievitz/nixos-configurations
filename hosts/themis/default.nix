{ lib, config, pkgs, ... }: {
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./xserver.nix
  ];
  networking = {
    hostName = "themis";
    # interfaces.enp3s0.useDHCP = true;
    interfaces.wlp4s0.useDHCP = true;
  };
  hardware.bluetooth = {
    enable = true;
    settings = { General = { Enable = "Source,Sink,Media,Socket"; }; };
  };
  boot = {
    initrd.kernelModules = [ "nvidia" "amdgpu" ];
    kernelParams = [ "pci=noats" ];
    plymouth = { enable = true; };
  };
  hardware.system76.enableAll = true;
}
