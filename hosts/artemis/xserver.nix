{ config, lib, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    videoDrivers = [ "amdgpu" ];
    desktopManager = {
      xterm.enable = false;
      session = [{
        manage = "qtile";
        name = "qtile";
        start = ''
          ${pkgs.qtile}/bin/qtile start -b wayland
        '';
      }];
    };
    displayManager = {
      sddm = {
        enable = true;
        autoNumlock = true;

      };
      defaultSession = "none+qtile";
    };
    windowManager.qtile.enable = true;
    layout = "pl";
    xkbOptions = "caps:swapescape";
    libinput = {
      enable = true;
      touchpad = {
        naturalScrolling = true;
        disableWhileTyping = true;
      };
      mouse = { accelProfile = "flat"; };
    };
  };
}
