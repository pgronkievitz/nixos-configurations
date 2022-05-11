let
  servicename = "n8nio";
  shortname = "n8n";
in { config, ... }: {
  virtualisation.oci-containers = {
    containers = {
      "${servicename}" = {
        image = "n8nio/n8n:0.176.0";
        environment = {
          TZ = "Europe/Warsaw";
          GENERIC_TIMEZONE = "Europe/Warsaw";
        };
        volumes = [ "/media/data/${servicename}:/home/node/.n8n" ];
        extraOptions = [
          "--label=traefik.http.routers.${servicename}.rule=Host(`${shortname}.gronkiewicz.xyz`,`${shortname}.lab.home`)"
          "--label=traefik.http.routers.${servicename}.tls=true"
        ];
      };
    };
  };
}
