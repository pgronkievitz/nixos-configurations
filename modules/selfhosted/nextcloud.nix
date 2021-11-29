let
  servicename = "nextcloud";
  shortname = "nc";
  port = "9101";
in {
  virtualisation.oci-containers = {
    containers = {
      "${servicename}" = {
        image = "lscr.io/linuxserver/nextlcoud:php8-version-22.2.3";
        volumes = [
          "/media/data/${servicename}:/data"
          "/media/data/${servicename}_config:/config"
        ];
        ports = [ "${port}:80" ];
        environment = {
          REDIS_HOST = "nc_redis";
          POSTGRES_DB = "nc_postgres";
        };
        user = "podman";
      };
      "${shortname}_postgres" = {
        image = "docker.io/postgresql:13.5-alpine";
        volumes = [ "/media/data/${servicename}_db:/var/lib/postgresql/data" ];
        user = "podman";
      };
      "${shortname}_redis" = {
        image = "docker.io/redis:6.2.6-alpine";
        volumes = [ "/media/data/${servicename}_redis:/data" ];
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
