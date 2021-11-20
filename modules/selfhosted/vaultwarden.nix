let
  servicename = "vaultwarden";
  shortname = "vault";
  port = 9001;
in {
  virtualisation.oci-containers = {
    containers = {
      "${servicename}" = {
        image = "vaultwarden/server:1.23.0-alpine";
        volumes = [ "/media/data/${servicename}:/data" ];
        ports = [ "${port}:80" ];
        environment = {
          WEBSOCKET_ENABLED = "true";
          DOMAIN = "https://${shortname}.gronkiewicz.xyz";
          SIGNUPS_ALLOWED = "false";
        };
        user = "${servicename}:services";
      };
    };
  };
  };
}
