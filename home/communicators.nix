{ pkgs, ... }: {
  home.packages = [
    pkgs.teams
    pkgs.slack
    pkgs.discord
    pkgs.thunderbird-bin-91
    pkgs.birdtray
    pkgs.tdesktop
  ];
}
