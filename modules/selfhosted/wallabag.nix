let
  servicename = "wallabag";
  shortname = "wb";
  port = 9201;
in {
  virtualisation.oci-containers = {
    containers = {
      "${servicename}" = {
        image = "wallabag/wallabag:2.4.2";
        volumes = [ "/media/data/${servicename}:/var/www/wallabag/data" ];
        ports = [ "${port}:80" ];
        environment = {
          "SYMFONY__ENV__DOMAIN_NAME" =
            "https://${servicename}.gronkiewicz.xyz";
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
