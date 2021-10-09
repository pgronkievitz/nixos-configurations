{ config, lib, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    videoDrivers = [ "amdgpu" ];
    desktopManager = { xterm.enable = false; };
    displayManager = {
      sddm.enable = true;
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
