let
  servicename = "vaultwarden";
  shortname = "vault";
  port = "9001";
in {
  virtualisation.oci-containers = {
    containers = {
      "${servicename}" = {
        image = "docker.io/vaultwarden/server:1.23.0-alpine";
        volumes = [ "/media/data/${servicename}:/data" ];
        ports = [ "${port}:80" ];
        environment = {
          WEBSOCKET_ENABLED = "true";
          DOMAIN = "https://${shortname}.gronkiewicz.xyz";
          SIGNUPS_ALLOWED = "false";
        };
      };
    };
  };
  services.nginx.virtualHosts = {
    "${shortname}.gronkiewicz.xyz" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "https://127.0.0.1:${port}";
        extraConfig = "proxy_ssl_server_name on;"
          + "proxy_pass_header Authorization;";
      };
      serverAliases = [
        "www.${shortname}.gronkiewicz.xyz"
        "${servicename}.gronkiewicz.xyz"
        "www.${servicename}.gronkiewicz.xyz"
      ];
    };
  };
}
