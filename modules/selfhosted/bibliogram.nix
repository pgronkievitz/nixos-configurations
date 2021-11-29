let
  servicename = "bibliogram";
  shortname = "bib";
  port = "9301";
in {
  virtualisation.oci-containers = {
    containers = {
      "${servicename}" = {
        image = "docker.io/cloudrac3r/bibliogram:latest";
        ports = [ "${port}:10407" ];
        environment = {
          "SYMFONY__ENV__DOMAIN_NAME" =
            "https://${servicename}.gronkiewicz.xyz";
        };
        user = "podman";
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
