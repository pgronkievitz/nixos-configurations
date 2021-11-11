{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.go
    pkgs.gocode
    pkgs.gomodifytags
    pkgs.gotests
    pkgs.gore
    pkgs.gopls
    pkgs.hugo
  ];
}
