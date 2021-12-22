{ pkgs, ... }: {
  xsession = {
    enable = true;
    numlock.enable = true;
  };
  home.packages = [
    pkgs.autorandr
    pkgs.arandr
    pkgs.picom
    pkgs.xorg.xwininfo
    pkgs.xclip
    pkgs.xwallpaper
    pkgs.brillo
    pkgs.lxappearance
    pkgs.pinentry-qt
    pkgs.betterlockscreen
    pkgs.maim
    pkgs.numlockx
  ];
}
