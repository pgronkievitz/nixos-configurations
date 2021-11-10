{ config, lib, pkgs, ... }:

{
  services.prometheus.exporters = {
    node = {
      enable = true;
      openFirewall = true;
    };
  };
}
