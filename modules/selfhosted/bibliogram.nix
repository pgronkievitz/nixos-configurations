let
  servicename = "bibliogram";
  shortname = "bib";
  port = 9301;
in {
  virtualisation.oci-containers = {
    containers = {
      "${servicename}" = {
        image = "cloudrac3r/bibliogram:latest";
        ports = [ "${port}:10407" ];
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
    isSystemUser = true;
  };
}
