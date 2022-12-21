let
  servicename = "paperless";
  shortname = "docs";
in
{ config, ... }: {
  virtualisation.oci-containers = {
    containers = {
      "${servicename}" = {
        image = "ghcr.io/paperless-ngx/paperless-ngx:1.10.2";
        volumes = [
          "/media/data/${servicename}/config:/usr/src/paperless/data"
          "/media/data/${servicename}/data/consume:/usr/src/paperless/consume"
          "/media/data/${servicename}/data/media:/usr/src/paperless/media"
          "/media/data/${servicename}/data/export:/usr/src/paperless/export"
        ];
        environment = {
          TZ = "Europe/Warsaw";
          USERMAP_UID = "1000";
          USERMAP_GID = "1000";
          PAPERLESS_URL = "https://${shortname}.lab.home";
          PAPERLESS_REDIS = "redis://${servicename}-redis:6379";
        };
        extraOptions = [
          "--label=traefik.http.routers.${servicename}.rule=Host(`${shortname}.lab.home`)"
          "--label=traefik.http.routers.${servicename}.tls=true"
          "--network=${servicename}"
        ];
      };
      "${servicename}-redis" = {
        image = "redis:7.0.4-alpine";
        volumes = [ "/media/data/${servicename}/redis:/usr/local/etc/redis" ];
        extraOptions = [ "--network=${servicename}" ];
      };
    };
  };
}
