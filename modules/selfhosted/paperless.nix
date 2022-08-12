let
  servicename = "paperless";
  shortname = "docs";
in { config, ... }: {
  virtualisation.oci-containers = {
    containers = {
      "${servicename}" = {
        image = "lscr.io/linuxserver/paperless-ngx:1.8.0";
        volumes = [
          "/media/data/${servicename}/config:/config"
          "/media/data/${servicename}/data:/data"
        ];
        environment = {
          TZ = "Europe/Warsaw";
          PUID = "1000";
          PGID = "1000";
          PAPERLESS_URL = "https://${shortname}.lab.home";
        };
        extraOptions = [
          "--label=traefik.http.routers.${servicename}.rule=Host(`${shortname}.gronkiewicz.xyz`,`${shortname}.lab.home`)"
          "--label=traefik.http.routers.${servicename}.tls=true"
        ];
      };
    };
  };
}
