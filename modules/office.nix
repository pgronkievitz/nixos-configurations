{ pkgs, ... }:
let
  my-dicts = dicts: with dicts; [ en pl en-computers en-science ];
  my-aspell = pkgs.aspellWithDicts my-dicts;
in {
  environment.systemPackages = with pkgs; [
    libreoffice-fresh
    xkcd-font
    gammastep
    texlive.combined.scheme-medium
    gimp
    pandoc
    my-aspell
    ispell
    languagetool
    thunderbird-bin-91
    birdtray
    teams
    kotatogram-desktop
    pcmanfm
    pavucontrol
    pamixer
    alsa-utils
    spotify
    firefox
    brave
  ];
  fonts.fonts = with pkgs; [ nerdfonts ];
}
