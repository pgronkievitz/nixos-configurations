let
  servicename = "radarr";
  shortname = "rad";
in { config, ... }: {
  virtualisation.oci-containers = {
    containers = {
      "${servicename}" = {
        image = "lscr.io/linuxserver/radarr:4.1.0";
        volumes = [
          "/media/data/${servicename}/config:/config"
          "/media/data/${servicename}/movies:/movies"
          "/media/data/${servicename}/downloads:/downloads"
        ];
        environment.TZ = "Europe/Warsaw";
        extraOptions = [
          "--label=traefik.http.routers.${servicename}.rule=Host(`${shortname}.gronkiewicz.xyz`,`${shortname}.lab.home`)"
          "--label=traefik.http.routers.${servicename}.tls=true"
        ];
      };
    };
  };
}
