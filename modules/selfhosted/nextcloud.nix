let
  servicename = "nextcloud";
  shortname = "nc";
  port = "9101";
  domains = [
    "www.${shortname}.gronkiewicz.xyz"
    "${servicename}.gronkiewicz.xyz"
    "www.${servicename}.gronkiewicz.xyz"
  ];
in { config, ... }: {
  virtualisation.oci-containers = {
    containers = {
      "${servicename}" = {
        image = "nextcloud:23.0.0";
        volumes = [ "/media/data/${servicename}:/var/www/html" ];
        ports = [ "${port}:80" ];
        environment = {
          # REDIS_HOST = "nc_redis";
          POSTGRES_DB = "nc_postgres";
        };
      };
      "${shortname}_postgres" = {
        image = "docker.io/postgresql:13.5-alpine";
        volumes = [ "/media/data/${servicename}_db:/var/lib/postgresql/data" ];
      };
      # "${shortname}_redis" = {
      #   image = "docker.io/redis:6.2.6-alpine";
      #   volumes = [ "/media/data/${servicename}_redis:/data" ];
      # };
    };
  };
  services.nginx.virtualHosts = {
    "${shortname}.gronkiewicz.xyz" = {
      useACMEHost = "${shortname}.gronkiewicz.xyz";
      forceSSL = true;
      locations."/".proxyPass = "http://127.0.0.1:${port}";
      serverAliases = domains;
    };
  };
  security.acme.certs."${shortname}.gronkiewicz.xyz" = {
    extraDomainNames = domains;
    dnsProvider = "cloudflare";
    credentialsFile = config.age.secrets.cloudflare.path;
  };
}
