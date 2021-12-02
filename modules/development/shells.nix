{ config, lib, pkgs, ... }: {
  environment.systemPackages = [ pkgs.shellcheck ];
}
