let
  servicename = "calibre";
  shortname = "cal";
in
{ config, ... }: {
  virtualisation.oci-containers = {
    containers = {
      "${servicename}" = {
        image = "lscr.io/linuxserver/calibre-web:0.6.19";
        volumes = [
          "/media/data/${servicename}/config:/config"
          "/media/data/${servicename}/books:/books"
        ];
        environment = {
          TZ = "Europe/Warsaw";
          DOCKER_MODS = "linuxserver/calibre-web:calibre";
        };
        extraOptions = [
          "--label=traefik.http.routers.${servicename}.rule=Host(`${shortname}.gronkiewicz.xyz`,`${shortname}.lab.home`)"
          "--label=traefik.http.routers.${servicename}.tls=true"
        ];
      };
      "${servicename}-regular" = {
        image = "lscr.io/linuxserver/calibre:6.10.0";
        volumes = [
          "/media/data/${servicename}/regular_confg:/config"
          "/media/data/${servicename}/books:/config/Calibre Library"
        ];
        environment = {
          TZ = "Europe/Warsaw";
        };
        extraOptions = [
          "--label=traefik.http.routers.${servicename}desktop.rule=Host(`${shortname}-desktop.lab.home`)"
          "--label=traefik.http.services.${servicename}desktop.loadbalancer.server.port=8080"
          "--label=traefik.http.routers.${servicename}desktop.tls=true"
        ];
      };
    };
  };
}
