{ pkgs, ... }: {
  home.packages = [
    pkgs.zotero
    pkgs.calibre
    pkgs.megasync
    pkgs.youtube-dl
    pkgs.freetube
    pkgs.bitwarden
  ];
}
