{ config, pkgs, ... }: {
  imports = [ ./hardware-configuration.nix ./xserver.nix ./backups.nix ];
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
  networking = {
    hostName = "artemis";
    domain = "gronkiewicz.xyz";
    interfaces.enp2s0.useDHCP = true;
    interfaces.wlo1.useDHCP = true;
  };
  hardware.bluetooth = {
    enable = true;
    settings.General.Enable = "Source,Sink,Media,Socket";
  };

  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="amdgpu_bl0", MODE="0666", RUN+="${pkgs.coreutils}/bin/chmod a+w /sys/class/backlight/%k/brightness"
  '';
  security.pam.u2f = {
    enable = true;
    authFile = "/home/pg/.config/Yubico/u2fkeys";
    control = "required";
  };
  services.openssh.listenAddresses = [
    {
      addr = "100.113.244.67";
      port = 14442;
    }
    {
      addr = "127.0.0.1";
      port = 14442;
    }
  ];
}
