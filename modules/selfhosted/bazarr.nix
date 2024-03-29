let
  servicename = "bazarr";
  shortname = "baz";
in
{ config, ... }: {
  virtualisation.oci-containers = {
    containers = {
      "${servicename}" = {
        image = "lscr.io/linuxserver/bazarr:1.1.3";
        volumes = [
          "/media/data/${servicename}/config:/config"
          "/media/data/sonarr/tv:/tv"
          "/media/data/radarr/downloads:/downloads"
        ];
        environment.TZ = "Europe/Warsaw";
        extraOptions = [
          "--label=traefik.http.routers.${servicename}.rule=Host(`${shortname}.lab.home`)"
          "--label=traefik.http.routers.${servicename}.tls=true"
          "--network=torrenting"
        ];
      };
    };
  };
}
