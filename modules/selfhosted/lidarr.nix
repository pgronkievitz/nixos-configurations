let
  servicename = "lidarr";
  shortname = "lid";
in { config, ... }: {
  virtualisation.oci-containers = {
    containers = {
      "${servicename}" = {
        image = "lscr.io/linuxserver/lidarr:0.8.1-develop";
        volumes = [
          "/media/data/${servicename}/config:/config"
          "/media/data/${servicename}/music:/music"
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
