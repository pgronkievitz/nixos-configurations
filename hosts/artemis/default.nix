{ lib, config, pkgs, ... }: {
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./xserver.nix
    ./audio.nix
    ./backups.nix
  ];
  boot = {
    extraModulePackages = [ config.boot.kernelPackages.tuxedo-keyboard ];
    kernelParams = [
      "pci=noats"
      "tuxedo_keyboard.mode=0"
      "tuxedo_keyboard.brightness=4"
      "tuxedo_keybaord.color_left=0x00ffff"
    ];
  };
  networking = {
    hostName = "artemis";
    interfaces.enp2s0.useDHCP = true;
    interfaces.wlo1.useDHCP = true;
  };
  hardware.bluetooth = {
    enable = true;
    settings = { General = { Enable = "Source,Sink,Media,Socket"; }; };
  };

  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="amdgpu_bl0", MODE="0666", RUN+="${pkgs.coreutils}/bin/chmod a+w /sys/class/backlight/%k/brightness"
  '';
}
