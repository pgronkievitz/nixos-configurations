{ pkgs, ... }: {
  home.packages =
    [ pkgs.fd pkgs.killall pkgs.ripgrep pkgs.tealdeer pkgs.sqlite ];
}
