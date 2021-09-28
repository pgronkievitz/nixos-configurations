{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    autorandr
    networkmanagerapplet
    htop
    picom
    arandr
    xorg.xwininfo
    xclip
    xwallpaper
    brillo
    lxappearance
    numlockx
    blueman
    pinentry-qt
    # ocrmypdf
    multilockscreen
    maim
    megasync
    youtube-dl
    freetube
    calibre
    spectacle
  ];

}
