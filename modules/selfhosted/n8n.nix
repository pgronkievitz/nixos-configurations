let
  servicename = "n8nio";
  shortname = "n8n";
in { config, ... }: {
  virtualisation.oci-containers = {
    containers = {
      "${servicename}" = {
        image = "n8nio/n8n:0.199.0";
        environment = {
          TZ = "Europe/Warsaw";
          GENERIC_TIMEZONE = "Europe/Warsaw";
          N8N_EDITOR_BASE_URL = "https://n8n.lab.home";
          N8N_DIAGNOSTICS_ENABLED = "false";
          WEBHOOK_URL = "https://n8n.gronkiewicz.dev";
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
