let
  servicename = "lenpaste";
  shortname = "paste";
in { config, ... }: {
  virtualisation.oci-containers = {
    containers = {
      "${servicename}" = {
        image = "git.lcomrade.su/root/lenpaste:1.1.1";
        environment = {
          LENPASTE_ADDRESS = ":80";
          LENPASTE_DB_DRIVER = "sqlite3";
          LENPASTE_DB_SOURCE = "/data/lenpaste.db";
          LENPASTE_DB_CLEANUP_PERIOD = "3h";
          LENPASTE_ROBOTS_DISALLOW = "true";
          LENPASTE_TITLE_MAX_LENGTH = "100";
          LENPASTE_BODY_MAX_LENGTH = "10000";
          LENPASTE_MAX_PASTE_LIFETIME = "365d";
          LENPASTE_ADMIN_NAME = "pgronkievitz";
          LENPASTE_ADMIN_MAIL = "paste@gronkiewicz.dev";
        };
        volumes = [
          "/etc/timezone:/etc/timezone:ro"
          "/etc/localtime:/etc/localtime:ro"
          "/media/data/${servicename}:/data"
        ];
        extraOptions = [
          "--label=traefik.http.routers.${servicename}.rule=Host(`${shortname}.gronkiewicz.dev`)"
          "--label=traefik.http.services.${servicename}.loadbalancer.server.port=80"
          "--label=traefik.http.routers.${servicename}.tls=true"
          "--label=traefik.http.routers.${servicename}.tls.certresolver=letsencrypt"
        ];
      };
    };
  };
}
