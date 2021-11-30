{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.gcc pkgs.clang ];
}
