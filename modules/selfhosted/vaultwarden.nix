let
  servicename = "vaultwarden";
  shortname = "vault";
in { config, ... }: {
  virtualisation.oci-containers = {
    containers = {
      "${servicename}" = {
        image = "vaultwarden/server:1.26.0-alpine";
        volumes = [ "/media/data/${servicename}:/data" ];
        environment = {
          WEBSOCKET_ENABLED = "true";
          DOMAIN = "https://${shortname}.gronkiewicz.xyz";
          SIGNUPS_ALLOWED = "false";
        };
        extraOptions = [
          "--label=traefik.http.routers.${servicename}.rule=Host(`${shortname}.gronkiewicz.xyz`,`${shortname}.lab.home`)"
          "--label=traefik.http.routers.${servicename}.tls=true"
        ];
      };
    };
  };
}
