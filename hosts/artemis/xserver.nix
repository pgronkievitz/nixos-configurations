{ config, lib, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    desktopManager = { xterm.enable = false; };
    displayManager = {
      lightdm.extraConfig =
        "display-setup-script=/home/pg/.screenlayout/default.sh";
      defaultSession = "none+qtile";
    };
    windowManager.qtile = { enable = true; };
    layout = "pl";
    xkbOptions = "caps:swapescape";
    libinput.enable = true;
  };
}
