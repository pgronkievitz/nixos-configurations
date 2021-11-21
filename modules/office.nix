{ pkgs, ... }:
let
  my-dicts = dicts: with dicts; [ en pl en-computers en-science ];
  my-aspell = pkgs.aspellWithDicts my-dicts;
in {
  environment.systemPackages = [
    pkgs.libreoffice-fresh
    pkgs.xkcd-font
    pkgs.gammastep
    pkgs.texlive.combined.scheme-full
    pkgs.gimp
    pkgs.pandoc
    my-aspell
    pkgs.ispell
    pkgs.languagetool
    pkgs.thunderbird-bin-91
    pkgs.birdtray
    pkgs.teams
    pkgs.slack
    pkgs.discord
    pkgs.kotatogram-desktop
    pkgs.pcmanfm
    pkgs.pavucontrol
    pkgs.pamixer
    pkgs.alsa-utils
    pkgs.spotify
    pkgs.firefox
    pkgs.brave
    pkgs.nextcloud-client
  ];
  fonts.fonts = [ pkgs.nerdfonts ];
}
