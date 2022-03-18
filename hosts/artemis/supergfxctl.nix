{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.supergfxctl;
  configFile = pkgs.writeText "supergfxd.conf" (builtins.toJSON ({
    gfx_mode = cfg.gfx-mode;
    gfx_managed = cfg.gfx-managed;
    gfx_vfio_enable = cfg.gfx-vfio-enable;
  }));
in {
  ###### interface

  options = {
    services.supergfxctl = {
      enable = mkOption {
        description = ''
          Enable this option to enable control of GPU modes with supergfxctl.

          This permits you to switch between integrated, hybrid and dedicated
          graphics modes on supported laptops.
        '';
        type = types.bool;
        default = false;
      };
      gfx-mode = mkOption {
        description = "Sets the default GPU mode that is applied on boot.";
        type =
          types.enum [ "Nvidia" "Integrated" "Compute" "Vfio" "Egpu" "Hybrid" ];
        default = "Hybrid";
      };
      gfx-managed = mkOption {
        description = "Sets if the graphics management is enabled";
        type = types.bool;
        default = true;
      };
      gfx-vfio-enable = mkOption {
        description =
          "Sets if VFIO-Passthrough of the dedicated GPU is enabled.";
        type = types.bool;
        default = false;
      };
    };
  };

  ###### implementation

  config = mkIf config.services.supergfxctl.enable {
    environment.systemPackages = with pkgs.asus; [ supergfxctl ];
    services.dbus.packages = with pkgs.asus; [ supergfxctl ];
    services.udev.packages = with pkgs.asus; [ supergfxctl ];
    systemd.packages = with pkgs.asus; [ supergfxctl ];
    environment.etc."supergfxd.conf".source = configFile;
  };
}
