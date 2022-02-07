{ pkgs, ... }: {
  xsession = {
    enable = true;
    numlock.enable = true;
    windowManager.awesome = {
      enable = true;
      luaModules = [ pkgs.luaPackages.vicious ];
    };
  };
  home.packages = [
    pkgs.autorandr
    pkgs.arandr
    pkgs.xorg.xwininfo
    pkgs.xclip
    pkgs.xwallpaper
    pkgs.brillo
    pkgs.light
    pkgs.acpi
    pkgs.pinentry-qt
    pkgs.betterlockscreen
    pkgs.maim
    pkgs.numlockx
  ];
}
