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
  services.caddy.virtualHosts = {
    "${shortname}.gronkiewicz.xyz" = {
      serverAliases = [
        "www.${shortname}.gronkiewicz.xyz"
        "${servicename}.gronkiewicz.xyz"
        "www.${servicename}.gronkiewicz.xyz"
      ];
      extraConfig = ''
        reverse_proxy ${port}
        metrics /metrics
      '';
    };
  };
  users.extraUsers."${servicename}" = {
    extraGroups = [ "services" ];
    isNormalUser = false;
  };
}
