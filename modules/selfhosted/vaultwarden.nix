let
  servicename = "vaultwarden";
  shortname = "vault";
  port = "9001";
  domains = [
    "www.${shortname}.gronkiewicz.xyz"
    "${servicename}.gronkiewicz.xyz"
    "www.${servicename}.gronkiewicz.xyz"
  ];
in { config, ... }: {
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
