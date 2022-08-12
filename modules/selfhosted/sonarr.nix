let
  servicename = "sonarr";
  shortname = "son";
in { config, ... }: {
  virtualisation.oci-containers = {
    containers = {
      "${servicename}" = {
        image = "lscr.io/linuxserver/sonarr:3.0.9";
        volumes = [
          "/media/data/${servicename}/config:/config"
          "/media/data/${servicename}/tv:/tv"
          "/media/data/${servicename}/downloads:/downloads"
        ];
        environment.TZ = "Europe/Warsaw";
        extraOptions = [
          "--label=traefik.http.routers.${servicename}.rule=Host(`${shortname}.gronkiewicz.xyz`,`${shortname}.lab.home`)"
          "--label=traefik.http.routers.${servicename}.tls=true"
          "--network=torrenting"
        ];
      };
    };
  };
}
