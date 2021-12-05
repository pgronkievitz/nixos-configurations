let
  servicename = "wallabag";
  shortname = "wb";
  port = "9201";
  domains = [
    "www.${shortname}.gronkiewicz.xyz"
    "${servicename}.gronkiewicz.xyz"
    "www.${servicename}.gronkiewicz.xyz"
  ];
in { config, ... }: {
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
      };
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
