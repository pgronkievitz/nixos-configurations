{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.gcc pkgs.clang pkgs.gnumake pkgs.cmake ];
}
