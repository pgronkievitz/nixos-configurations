let
  servicename = "mealie";
  shortname = "recipes";
in
{ config, ... }: {
  virtualisation.oci-containers = {
    containers = {
      "${servicename}" = {
        image = "hkotel/mealie:latest";
        volumes = [
          "/media/data/${servicename}:/app/data"
        ];
        environment = {
          TZ = "Europe/Warsaw";
          PUID = "1000";
          PGID = "1000";
          BASE_URL = "https://${shortname}.lab.home";
        };
        extraOptions = [
          "--label=traefik.http.routers.${servicename}.rule=Host(`${shortname}.lab.home`)"
          "--label=traefik.http.routers.${servicename}.tls=true"
        ];
      };
    };
  };
}
