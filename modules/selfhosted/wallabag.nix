let
  servicename = "wallabag";
  shortname = "wb";
  port = "9201";
in {
  virtualisation.oci-containers = {
    containers = {
      "${servicename}" = {
        image = "docker.io/wallabag/wallabag:2.4.2";
        volumes = [ "/media/data/${servicename}:/var/www/wallabag/data" ];
        ports = [ "${port}:80" ];
        environment = {
          "SYMFONY__ENV__DOMAIN_NAME" =
            "https://${servicename}.gronkiewicz.xyz";
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
