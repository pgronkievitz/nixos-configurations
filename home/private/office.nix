{ pkgs, ... }: {
  home.packages = [
    pkgs.zotero
    # pkgs.calibre
    pkgs.megasync
    pkgs.youtube-dl
    pkgs.bitwarden
    pkgs.beancount
    pkgs.imagemagick
  ];
}
