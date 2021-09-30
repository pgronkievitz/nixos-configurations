{ lib, config, pkgs, ... }: {
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./xserver.nix
    ./audio.nix
  ];
  networking = {
    hostName = "themis";
    interfaces.enp2s0.useDHCP = true;
    interfaces.wlo1.useDHCP = true;
  };
  hardware.bluetooth = {
    enable = true;
    settings = { General = { Enable = "Source,Sink,Media,Socket"; }; };
  };
  boot = {
    extraModulePackages = [ config.boot.kernelPackages.tuxedo-keyboard ];
    initrd.kernelModules = [ "amdgpu" ];
    kernelParams = [
      "pci=noats"
      "tuxedo_keyboard.mode=0"
      "tuxedo_keyboard.brightness=4"
      "tuxedo_keybaord.color_left=0x00ffff"
    ];
    plymouth = { enable = true; };
  };
}
