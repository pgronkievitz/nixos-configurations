{ config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./xserver.nix
    ./backups.nix
    ./asusctl.nix
    ./supergfxctl.nix
  ];
  boot = {
    initrd.kernelModules = [ "amdgpu" ];
    kernelParams = [ "amd_pstate.shared_mem=1" ];
    plymouth.enable = true;
  };
  networking = {
    hostName = "artemis";
    domain = "gronkiewicz.xyz";
    hostId = "9b6802b9";
    interfaces.wlp2s0.useDHCP = true;
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
      addr = "0.0.0.0";
      port = 14442;
    }
    {
      addr = "127.0.0.1";
      port = 14442;
    }
  ];

  environment.systemPackages = [ pkgs.asus.asusctl pkgs.asus.supergfxctl ];
  services.asusctl.enable = true;
  services.supergfxctl = {
    enable = true;
    gfx-mode = "Integrated";
  };
}
