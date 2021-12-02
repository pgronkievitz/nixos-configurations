{ config, lib, pkgs, ... }: {
  environment.systemPackages = [
    pkgs.libtidy
    pkgs.nodejs
    pkgs.nodePackages.stylelint
    pkgs.nodePackages.js-beautify
  ];
}
