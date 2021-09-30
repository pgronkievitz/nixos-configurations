{ config, lib, pkgs, ... }: {
  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" "amdgpu" ];
    desktopManager = { xterm.enable = false; };
    displayManager = {
      sddm.enable = true;
      defaultSession = "none+qtile";
    };
    windowManager.qtile.enable = true;
    layout = "pl";
    xkbOptions = "caps:swapescape";
    libinput.enable = true;
  };
}
