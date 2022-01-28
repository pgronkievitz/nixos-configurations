{ pkgs, ... }:
let
  my-dicts = dicts: [ dicts.en dicts.pl dicts.en-computers dicts.en-science ];
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
    pkgs.zotero
    pkgs.playerctl
  ];
  programs.rbw = {
    enable = true;
    # settings = {
    #   base_url = "https://vault.gronkiewicz.xyz";
    #   # identity_url = "https://vault.gronkiewicz.xyz/identity";
    #   email = "vault@gronkiewicz.xyz";
    # };
  };
}
