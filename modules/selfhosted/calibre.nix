let
  servicename = "calibre";
  shortname = "cal";
in { config, ... }: {
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
    };
  };
}
