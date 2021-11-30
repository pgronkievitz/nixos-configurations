{ pkgs, ... }:
let
  my-dicts = dicts: with dicts; [ en pl en-computers en-science ];
  my-aspell = pkgs.aspellWithDicts my-dicts;
in {
  home.packages = [
    pkgs.libreoffice-fresh
    pkgs.xkcd-font
    pkgs.gammastep
    pkgs.texlive.combined.scheme-full
    pkgs.gimp
    pkgs.pandoc
    my-aspell
    pkgs.ispell
    pkgs.languagetool
    pkgs.pcmanfm
    pkgs.pavucontrol
    pkgs.pamixer
    pkgs.alsa-utils
    pkgs.spotify
    pkgs.firefox
    pkgs.brave
    pkgs.nextcloud-client
    pkgs.zotero
    pkgs.calibre
    pkgs.megasync
    pkgs.youtube-dl
    pkgs.freetube
  ];
}
