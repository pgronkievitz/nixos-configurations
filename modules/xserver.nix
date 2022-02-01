{ pkgs, ... }: {
  services.xserver = {
    enable = true;
    dpi = 96;
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
    windowManager = {
      qtile.enable = true;
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
