{ config, lib, pkgs, ... }: {
  environment.systemPackages = [
    pkgs.html-tidy
    pkgs.nodejs
    pkgs.nodePackages.stylelint
    pkgs.nodePackages.js-beautify
  ];
}
