{ config, pkgs, ... }: {

  services.gammastep = {
    enable = true;
    latitude = 50.041187;
    longitude = 21.999121;
    provider = "manual";
    temperature.night = 2700;
    tray = true;
  };
}
