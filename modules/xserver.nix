{ pkgs, lib, ... }: {
  services.xserver = {
    enable = true;
    dpi = 96;
    desktopManager.xterm.enable = false;
    displayManager = {
      sddm = {
        enable = true;
        autoNumlock = true;
      };
      defaultSession = "none+awesome";
    };
    windowManager = {
      awesome = {
        enable = true;
        luaModules = [ pkgs.luaPackages.luarocks pkgs.luaPackages.vicious ];
      };
    };
    layout = "pl";
    xkbOptions = "caps:swapescape";
    libinput = {
      enable = true;
      touchpad = {
        naturalScrolling = true;
        disableWhileTyping = true;
      };
      mouse.accelProfile = "flat";
    };
  };
}
