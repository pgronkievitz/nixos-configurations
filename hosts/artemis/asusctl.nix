{ config, lib, pkgs, ... }:

with lib;

{
  ###### interface

  options = {
    services.asusctl = {
      enable = mkOption {
        description = ''
          Use asusctl to control the lighting, fan curve, GPU mode and more
          on supported Asus laptops.
        '';
        type = types.bool;
        default = false;
      };
    };
  };

  ###### implementation

  config = mkIf config.services.asusctl.enable {
    services.supergfxctl.enable = true;
    environment.systemPackages = with pkgs.asus; [ asusctl ];
    services.dbus.packages = with pkgs.asus; [ asusctl ];
    services.udev.packages = with pkgs.asus; [ asusctl ];
    systemd.packages = with pkgs.asus; [ asusctl ];
  };
}
