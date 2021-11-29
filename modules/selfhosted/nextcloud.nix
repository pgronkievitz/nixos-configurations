let
  servicename = "nextcloud";
  shortname = "nc";
  port = 9101;
in {
  virtualisation.oci-containers = {
    containers = {
      "${servicename}" = {
        image = "nextlcoud:22.2.3-apache";
        volumes = [ "/media/data/${servicename}:/data" ];
        ports = [ "${port}:80" ];
        environment = {
          REDIS_HOST = "nc_redis";
          POSTGRES_DB = "nc_postgres";
        };
        user = "${servicename}:services";
      };
      "${shortname}_postgres" = {
        image = "postgresql:13.5-alpine";
        volumes = [ "/media/data/${servicename}_db:/var/lib/postgresql/data" ];
      };
      "${shortname}_redis" = {
        image = "redis:6.2.6-alpine";
        volumes = [ "/media/data/${servicename}_redis:/data" ];
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
