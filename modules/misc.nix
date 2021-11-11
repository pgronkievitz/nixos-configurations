{ pkgs, ... }: {

  environment.systemPackages = [
    pkgs.autorandr
    pkgs.networkmanagerapplet
    pkgs.htop
    pkgs.picom
    pkgs.arandr
    pkgs.xorg.xwininfo
    pkgs.xclip
    pkgs.xwallpaper
    pkgs.brillo
    pkgs.lxappearance
    pkgs.numlockx
    pkgs.blueman
    pkgs.pinentry-qt
    pkgs. # ocrmypdf
    pkgs.multilockscreen
    pkgs.maim
    pkgs.megasync
    pkgs.youtube-dl
    pkgs.freetube
    pkgs.calibre
    pkgs.spectacle
  ];

}
